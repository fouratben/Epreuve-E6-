Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\script\import.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "Employéss" -Path "dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Londres" -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Paris" -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Berlin" -Path "ou=Employéss,dc=imcsio2,dc=fr"

#*******Ajout de chaque utilisateur dans son OU spécifique*******

foreach ($user in $users){
    
    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department
    

    switch($user.office){
        "Paris" {$office = "OU=Paris,OU=Employéss,dc=imcsio2,DC=fr"}
        "Berlin" {$office = "OU=Berlin,OU=Employéss,dc=imcsio2,DC=fr"}
        "Londres" {$office = "OU=Londres,OU=Employéss,dc=imcsio2,DC=fr"}
        default {$office = $null}    
    }
    
     try {
            New-ADUser -Name $name -SamAccountName $login -UserPrincipalName $login -DisplayName $name -GivenName $fname -Surname $lname -AccountPassword (ConvertTo-SecureString $Upassword -AsPlainText -Force) -City $Uoffice -Path $office -Department $dept -Enabled $true
            echo "Utilisateur ajouté : $name"
          
           
        } catch{
            echo "utilisateur non ajouté : $name"
       }   

   }

   # ********Création des Groupes*********

New-ADGroup -Name Direction -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name Sales -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name Traders -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name Secretary -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"

#*********************Groupes sous Paris************************

New-ADGroup -Name DirectionParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SalesParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name TradersParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SecretaryParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employéss,dc=imcsio2,dc=fr"

#*********************Groupes sous Londres************************

New-ADGroup -Name DirectionLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SalesLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name TradersLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SecretaryLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Employéss,dc=imcsio2,dc=fr"

#*********************Groupes sous Berlin************************

New-ADGroup -Name DirectionBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SalesBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name TradersBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SecretaryBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Employéss,dc=imcsio2,dc=fr"

Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\script\importe.csv"

foreach ($user in $users){

    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department 


#********Ajout des utilisateurs de Paris dans leurs groupes********************

if ($Uoffice -eq "Paris" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesParis' -Members $login
} 

#********Ajout des utilisateurs de Londres dans leurs groupes********************

if ($Uoffice -eq "Londres" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesLondres' -Members $login
} 
#********Ajout des utilisateurs de Berlin dans leurs groupes********************

if ($Uoffice -eq "Berlin" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesBerlin' -Members $login
} 

} 

#Ajout des groupes dans les groupes

Add-ADGroupMember -Identity 'Direction' -Members DirectionParis,DirectionLondres,DirectionBerlin
Add-ADGroupMember -Identity 'Sales' -Members SalesParis,SalesLondres,SalesBerlin
Add-ADGroupMember -Identity 'Traders'-Members TradersParis,TradersLondres,TradersBerlin
Add-ADGroupMember -Identity 'Secretary' -Members SecretaryParis,SecretaryLondres,SecretaryBerlin
