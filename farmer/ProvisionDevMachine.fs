open System
open Farmer
open Farmer.Builders
open Farmer.TrafficManager
open Farmer.NetworkSecurity

let vmNamePrefix = "HD-Dev"
let vmName = $"{vmNamePrefix}-VM"
let userName = "helygan"
let nsgName = $"{vmName}NSG"
let vmHttpPorts = [443]
let getMyIp = (new System.Net.WebClient()).DownloadString("https://api.ipify.org");

// /// Open http ports
// let httpsRule = securityRule {
//     name $"{vmNamePrefix}HttpsRule"
//     services (vmHttpPorts |> List.map(fun p -> NetworkService ("http", uint16 p |> Port)))
//     add_source_tag NetworkProtocol.TCP "Internet"
//     add_destination_any
// }

// /// Open https port
// let httpRule = securityRule {
//     name $"{vmNamePrefix}HttpRule"
//     services [NetworkService ("http", uint16 80 |> Port)]
//     add_source_tag NetworkProtocol.TCP "Internet"
//     add_destination_any
// }

/// Allowed ports for VM:
let vmIpRules = // rule name, ip address, allow RDP 
    [ "Helygan_Access_Ip", getMyIp, true
        // "Office-ip-2021-09-03", "123.123.123.123", false
    ] |> List.map(fun (nm, ip, remote) ->
            securityRule {
                name nm
                services (seq {
                    // yield "CustomServicePortToOpen", 12345;
                    if remote then yield "rdp", 3389; 
                    })
                add_source_address NetworkProtocol.TCP ip
                add_destination_any
            })

let networkSecurityGroup = nsg {
    name nsgName
    add_rules (vmIpRules)
}

let developmentEnvironment = vm {
    name vmName
    network_security_group networkSecurityGroup
    username userName
    //vm_size Vm.Standard_B2s
    vm_size Vm.Standard_D4ds_v4
    operating_system Vm.WindowsServer_2019Datacenter
    os_disk 128 Vm.StandardSSD_LRS
    add_ssd_disk 128
    custom_script "powershell.exe -ExecutionPolicy Unrestricted -File remote-bootstrap-setup.ps1"
    custom_script_files [ 
        "https://raw.githubusercontent.com/AdamPrendergast/HelyganDevMachine/main/remote-bootstrap-setup.ps1"
    ]
}

let deployment = arm {
    location Location.UKWest
    add_resource developmentEnvironment
    add_resource networkSecurityGroup
}


// let gw = gateway {
//     name "helygan-dev-gateway"
//     vnet "my-vnet" // Must contain a subnet named 'GatewaySubnet'
//     er_gateway_sku ErGatewaySku.Standard

//     vpn_client
//         (vpnclient {
//            add_address_pool "10.31.0.0/16"
//            add_root_certificate "rootcert" "" })
// }

// let privateNet = vnet {
//     name "my-vnet"
//     add_address_spaces [
//         "10.30.0.0/16"
//     ]
//     add_subnets [
//         subnet {
//             name "GatewaySubnet"
//             prefix "10.30.254.0/28"
//         }
//     ]
// }

deployment 
|> Writer.quickWrite "arm\\dev-env"

// deployment
// |> Deploy.execute "scriptedDevTestGroup" ([$"password-for-{vmName}", "TestingOut123!"])
// |> ignore
