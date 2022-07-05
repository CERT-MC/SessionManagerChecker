#*********************************************************************#
#@Author: MMa For AMSN
#@Version: 1.0
#@Date: 04/07/2022
#@Description: Test SessionManager
#Use Smb to connect to all exchange servers and perform those checks.
#*********************************************************************#


#Imports
Add-PSSnapin Microsoft.Exchange.Management.Powershell.Snapin

#Environment
$Program_File = [system.Environment]::ExpandEnvironmentVariables("%PROGRAMFILES%")
$Windir = [system.Environment]::ExpandEnvironmentVariables("%WINDIR%")
$UserDesktop = [system.Environment]::GetFolderPath("Desktop")

If (!(Test-Path ("$UserDesktop\SessionManagerChecker"))){
    New-Item "$UserDesktop\SessionManagerChecker" -ItemType Directory 
}
#Indicators

$files_indicators = @(
    "$Program_File\Microsoft\Exchange Server\V15\ClientAccess\OWA\Auth\SessionManagerModule.dll",
    "$Program_File\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy\bin\SessionManagerModule.dll",
    "$Windir\System32\inetsrv\SessionManagerModule.dll",
    "$Windir\System32\inetsrv\SessionManager.dll",
    'C:\Windows\Temp\ExchangeSetup\Exch.ps1',
    'C:\Windows\Temp\Exch.exe',
    'C:\Windows\Temp\vmmsi.exe',
    'C:\Windows\Temp\safenet.exe',
    'C:\Windows\Temp\upgrade.exe',
    'C:\Windows\Temp\exupgrade.exe',
    'C:\Windows\Temp\dvvm.exe',
    'C:\Windows\Temp\vgauth.exe',
    'C:\Windows\Temp\win32.exe'
    )

#Exchange build numbers and cumulative updates #Docs.microsoft.com
        $BuildToProductName = @{
            '14.3.123.4'   = 'Microsoft Exchange Server 2010 SP3'
            #
            '15.0.620.29'  = 'Exchange Server 2013 Cumulative Update 1 (CU1)'
            '15.0.712.24'  = 'Exchange Server 2013 Cumulative Update 2 (CU2)'
            '15.0.775.38'  = 'Exchange Server 2013 Cumulative Update 3 (CU3)'
            '15.0.847.32'  = 'Exchange Server 2013 Service Pack 1 (CU4)'
            '15.0.913.22'  = 'Exchange Server 2013 Cumulative Update 5 (CU5)'
            '15.0.995.29'  = 'Exchange Server 2013 Cumulative Update 6 (CU6)'
            '15.0.1044.25' = 'Exchange Server 2013 Cumulative Update 7 (CU7)'
            '15.0.1076.9'  = 'Exchange Server 2013 Cumulative Update 8 (CU8)'
            '15.0.1104.5'  = 'Exchange Server 2013 Cumulative Update 9 (CU9)'
            '15.0.1130.7'  = 'Exchange Server 2013 Cumulative Update 10 (CU10)'
            '15.0.1156.6'  = 'Exchange Server 2013 Cumulative Update 11 (CU11)'
            '15.0.1178.4'  = 'Exchange Server 2013 Cumulative Update 12 (CU12)'
            '15.0.1210.3'  = 'Exchange Server 2013 Cumulative Update 13 (CU13)'
            '15.0.1236.3'  = 'Exchange Server 2013 Cumulative Update 14 (CU14)'
            '15.0.1263.5'  = 'Exchange Server 2013 Cumulative Update 15 (CU15)'
            '15.0.1293.2'  = 'Exchange Server 2013 Cumulative Update 16 (CU16)'
            '15.0.1320.4'  = 'Exchange Server 2013 Cumulative Update 17 (CU17)'
            '15.0.1347.2'  = 'Exchange Server 2013 Cumulative Update 18 (CU18)'
            '15.0.1365.1'  = 'Exchange Server 2013 Cumulative Update 19 (CU19)'
            '15.0.1367.3'  = 'Exchange Server 2013 Cumulative Update 20 (CU20)'
            '15.0.1395.4'  = 'Exchange Server 2013 Cumulative Update 21 (CU21)'
            '15.0.1473.3'  = 'Exchange Server 2013 Cumulative Update 22 (CU22)'
            '15.0.1497.2'  = 'Exchange Server 2013 Cumulative Update 23 (CU23)'
            #
            '15.1.396.30'  = 'Exchange Server 2016 Cumulative Update 1 (CU1)'
            '15.1.466.34'  = 'Exchange Server 2016 Cumulative Update 2 (CU2)'
            '15.1.544.27'  = 'Exchange Server 2016 Cumulative Update 3 (CU3)'
            '15.1.669.32'  = 'Exchange Server 2016 Cumulative Update 4 (CU4)'
            '15.1.845.34'  = 'Exchange Server 2016 Cumulative Update 5 (CU5)'
            '15.1.1034.26' = 'Exchange Server 2016 Cumulative Update 6 (CU6)'
            '15.1.1261.35' = 'Exchange Server 2016 Cumulative Update 7 (CU7)'
            '15.1.1415.2'  = 'Exchange Server 2016 Cumulative Update 8 (CU8)'
            '15.1.1466.3'  = 'Exchange Server 2016 Cumulative Update 9 (CU9)'
            '15.1.1531.3'  = 'Exchange Server 2016 Cumulative Update 10 (CU10)'
            '15.1.1591.10' = 'Exchange Server 2016 Cumulative Update 11 (CU11)'
            '15.1.1713.5'  = 'Exchange Server 2016 Cumulative Update 12 (CU12)'
            '15.1.1779.2'  = 'Exchange Server 2016 Cumulative Update 13 (CU13)'
            '15.1.1847.3'  = 'Exchange Server 2016 Cumulative Update 14 (CU14)'
            '15.1.1913.5'  = 'Exchange Server 2016 Cumulative Update 15 (CU15)'
            '15.1.1979.3'  = 'Exchange Server 2016 Cumulative Update 16 (CU16)'
            '15.1.2044.4'  = 'Exchange Server 2016 Cumulative Update 17 (CU17)'
            '15.1.2106.2'  = 'Exchange Server 2016 Cumulative Update 18 (CU18)'
            '15.1.2176.2'  = 'Exchange Server 2016 Cumulative Update 19 (CU19)'
            '15.1.2242.4'  = 'Exchange Server 2016 Cumulative Update 20 (CU20)'
            '15.1.2308.8'  = 'Exchange Server 2016 Cumulative Update 21 (CU21)'
            '15.1.2375.7'  = 'Exchange Server 2016 Cumulative Update 22 (CU22)'
            '15.1.2507.9'  = 'Exchange Server 2016 Cumulative Update 23 (CU23)'
            #
            '15.2.330.5'   = 'Exchange Server 2019 Cumulative Update 1 (CU1)'
            '15.2.397.3'   = 'Exchange Server 2019 Cumulative Update 2 (CU2)'
            '15.2.464.5'   = 'Exchange Server 2019 Cumulative Update 3 (CU3)'
            '15.2.529.5'   = 'Exchange Server 2019 Cumulative Update 4 (CU4)'
            '15.2.595.3'   = 'Exchange Server 2019 Cumulative Update 5 (CU5)'
            '15.2.659.4'   = 'Exchange Server 2019 Cumulative Update 6 (CU6)'
            '15.2.721.2'   = 'Exchange Server 2019 Cumulative Update 7 (CU7)'
            '15.2.792.3'   = 'Exchange Server 2019 Cumulative Update 8 (CU8)'
            '15.2.858.5'   = 'Exchange Server 2019 Cumulative Update 9 (CU9)'
            '15.2.922.7'   = 'Exchange Server 2019 Cumulative Update 10 (CU10)'
            '15.2.986.5'   = 'Exchange Server 2019 Cumulative Update 11 (CU11)'
            '15.2.1118.7'   = 'Exchange Server 2019 Cumulative Update 12 (CU12)'
        }

Start-Transcript -Path "$UserDesktop\SessionManagerChecker\SessionManagerChecker_log.txt"

# EXCHANGE INFORMATION
Write-host "**  EXCHANGE INFORMATIONS **"
    $Servers = Get-ExchangeServer -ErrorAction Stop
Write-host "|SRVNAME   |DOMAIN  |EDITION  |Build  | Product" 

    Foreach ($Server in $Servers){
                $Version = $Server.AdminDisplayVersion
                $Version = [regex]::Matches($Version, "(\d*\.\d*)").value -join '.'
 
                $Product = $BuildToProductName[$Version]
 
                $Object = [pscustomobject]@{
                    ServerName   = $Server.Name
                    Domain       = $Server.Domain
                    Edition      = $Server.Edition
                    BuildNumber  = $Version
                    ProductName  = $Product
                     
                }
                Write-host "|  " $Object.ServerName "  |  "  $Object.Domain  "  |  "  $Object.Edition  "  |  " $Object.BuildNumber "  |  " $Object.ProductName 
}

     Foreach ($Server in $Servers){
        #TEST INDICATORS of COMPROMISES
        $id = 0
        Write-host "**  TEST INDICATORS of COMPROMISES : $Server **"
        Write-host "|  HIT   | PATH"

        $files_indicators | ForEach-Object {

           $File_Hit = [System.IO.File]::Exists(($PSItem).replace("C:\", "\\$Server\c$\"))

            if ($File_Hit){   
            Write-host "| TRUE   | $PSItem" -ForegroundColor Red
            $id ++
            }
            else
            {
            Write-host "| FALSE  | $PSItem" -ForegroundColor Gray
            }

        }
         if ($id){
            Write-host "| Nb Hit | $Id --> !!! Check needed  !!!" -ForegroundColor Red
            }else{
            Write-host "| Nb Hit | $Id --> System OK" -ForegroundColor Green
            }
    }

Stop-Transcript
