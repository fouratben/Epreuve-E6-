Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\script\importe.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "Employéss" -Path "dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Londress" -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Pariss" -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Berlinn" -Path "ou=Employéss,dc=imcsio2,dc=fr"

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
        "Pariss" {$office = "OU=Pariss,OU=Employéss,dc=imcsio2,DC=fr"}
        "Berlinn" {$office = "OU=Berlinn,OU=Employéss,dc=imcsio2,DC=fr"}
        "Londress" {$office = "OU=Londress,OU=Employéss,dc=imcsio2,DC=fr"}
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

New-ADGroup -Name Directionn -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name Saless -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name Traderss -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name Secretaryy -GroupScope Global -GroupCategory Security -Path "ou=Employéss,dc=imcsio2,dc=fr"

#*********************Groupes sous Pariss************************

New-ADGroup -Name DirectionnPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SalessPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name TraderssPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SecretaryyPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Employéss,dc=imcsio2,dc=fr"

#*********************Groupes sous Londress************************

New-ADGroup -Name DirectionnLondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SalessLondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name TraderssLondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SecretaryyLondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Employéss,dc=imcsio2,dc=fr"

#*********************Groupes sous Berlinn************************

New-ADGroup -Name DirectionnBerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SalessBerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name TraderssBerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Employéss,dc=imcsio2,dc=fr"
New-ADGroup -Name SecretaryyBerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Employéss,dc=imcsio2,dc=fr"

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


#********Ajout des utilisateurs de Pariss dans leurs groupes********************

if ($Uoffice -eq "Pariss" -and $dept -eq "Directionn"){

    Add-ADGroupMember -Identity 'DirectionnPariss' -Members $login

}
elseif ($Uoffice -eq "Pariss" -and $dept -eq "Traderss"){

    Add-ADGroupMember -Identity 'TraderssPariss' -Members $login

}
elseif ($Uoffice -eq "Pariss" -and $dept -eq "Secretaryy"){

    Add-ADGroupMember -Identity 'SecretaryyPariss' -Members $login

}
elseif ($Uoffice -eq "Pariss" -and $dept -eq "Saless"){

    Add-ADGroupMember -Identity 'SalessPariss' -Members $login
} 

#********Ajout des utilisateurs de Londress dans leurs groupes********************

if ($Uoffice -eq "Londress" -and $dept -eq "Directionn"){

    Add-ADGroupMember -Identity 'DirectionnLondress' -Members $login

}
elseif ($Uoffice -eq "Londress" -and $dept -eq "Traderss"){

    Add-ADGroupMember -Identity 'TraderssLondress' -Members $login

}
elseif ($Uoffice -eq "Londress" -and $dept -eq "Secretaryy"){

    Add-ADGroupMember -Identity 'SecretaryyLondress' -Members $login

}
elseif ($Uoffice -eq "Londress" -and $dept -eq "Saless"){

    Add-ADGroupMember -Identity 'SalessLondress' -Members $login
} 
#********Ajout des utilisateurs de Berlinn dans leurs groupes********************

if ($Uoffice -eq "Berlinn" -and $dept -eq "Directionn"){

    Add-ADGroupMember -Identity 'DirectionnBerlinn' -Members $login

}
elseif ($Uoffice -eq "Berlinn" -and $dept -eq "Traderss"){

    Add-ADGroupMember -Identity 'TraderssBerlinn' -Members $login

}
elseif ($Uoffice -eq "Berlinn" -and $dept -eq "Secretaryy"){

    Add-ADGroupMember -Identity 'SecretaryyBerlinn' -Members $login

}
elseif ($Uoffice -eq "Berlinn" -and $dept -eq "Saless"){

    Add-ADGroupMember -Identity 'SalessBerlinn' -Members $login
} 

} 

#Ajout des groupes dans les groupes

Add-ADGroupMember -Identity 'Directionn' -Members DirectionnPariss,DirectionnLondress,DirectionnBerlinn
Add-ADGroupMember -Identity 'Saless' -Members SalessPariss,SalessLondress,SalessBerlinn
Add-ADGroupMember -Identity 'Traderss'-Members TraderssPariss,TraderssLondress,TraderssBerlinn
Add-ADGroupMember -Identity 'Secretaryy' -Members SecretaryyPariss,SecretaryyLondress,SecretaryyBerlinn
