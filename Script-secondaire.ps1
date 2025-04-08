Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\script\importe.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "Liguess" -Path "dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Londress" -Path "ou=Liguess,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Pariss" -Path "ou=Liguess,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Berlinn" -Path "ou=Liguess,dc=imcsio2,dc=fr"

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
        "Pariss" {$office = "OU=Pariss,OU=Liguess,dc=imcsio2,DC=fr"}
        "Berlinn" {$office = "OU=Berlinn,OU=Liguess,dc=imcsio2,DC=fr"}
        "Londress" {$office = "OU=Londress,OU=Liguess,dc=imcsio2,DC=fr"}
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

New-ADGroup -Name MMAA -GroupScope Global -GroupCategory Security -Path "ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name Boxes -GroupScope Global -GroupCategory Security -Path "ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name Tenniss -GroupScope Global -GroupCategory Security -Path "ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name Judoo -GroupScope Global -GroupCategory Security -Path "ou=Liguess,dc=imcsio2,dc=fr"

#*********************Groupes sous Pariss************************

New-ADGroup -Name MMAAPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name BoxesPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name TennissPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name JudooPariss -GroupScope Global -GroupCategory Security -Path "ou=Pariss,ou=Liguess,dc=imcsio2,dc=fr"

#*********************Groupes sous Londress************************

New-ADGroup -Name MMAALondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name BoxesLondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name TennissLondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name JudooLondress -GroupScope Global -GroupCategory Security -Path "ou=Londress,ou=Liguess,dc=imcsio2,dc=fr"

#*********************Groupes sous Berlinn************************

New-ADGroup -Name MMAABerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name BoxesBerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name TennissBerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Liguess,dc=imcsio2,dc=fr"
New-ADGroup -Name JudooBerlinn -GroupScope Global -GroupCategory Security -Path "ou=Berlinn,ou=Liguess,dc=imcsio2,dc=fr"

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

if ($Uoffice -eq "Pariss" -and $dept -eq "MMAA"){

    Add-ADGroupMember -Identity 'MMAAPariss' -Members $login

}
elseif ($Uoffice -eq "Pariss" -and $dept -eq "Tenniss"){

    Add-ADGroupMember -Identity 'TennissPariss' -Members $login

}
elseif ($Uoffice -eq "Pariss" -and $dept -eq "Judoo"){

    Add-ADGroupMember -Identity 'JudooPariss' -Members $login

}
elseif ($Uoffice -eq "Pariss" -and $dept -eq "Boxes"){

    Add-ADGroupMember -Identity 'BoxesPariss' -Members $login
} 

#********Ajout des utilisateurs de Londress dans leurs groupes********************

if ($Uoffice -eq "Londress" -and $dept -eq "MMAA"){

    Add-ADGroupMember -Identity 'MMAALondress' -Members $login

}
elseif ($Uoffice -eq "Londress" -and $dept -eq "Tenniss"){

    Add-ADGroupMember -Identity 'TennissLondress' -Members $login

}
elseif ($Uoffice -eq "Londress" -and $dept -eq "Judoo"){

    Add-ADGroupMember -Identity 'JudooLondress' -Members $login

}
elseif ($Uoffice -eq "Londress" -and $dept -eq "Boxes"){

    Add-ADGroupMember -Identity 'BoxesLondress' -Members $login
} 
#********Ajout des utilisateurs de Berlinn dans leurs groupes********************

if ($Uoffice -eq "Berlinn" -and $dept -eq "MMAA"){

    Add-ADGroupMember -Identity 'MMAABerlinn' -Members $login

}
elseif ($Uoffice -eq "Berlinn" -and $dept -eq "Tenniss"){

    Add-ADGroupMember -Identity 'TennissBerlinn' -Members $login

}
elseif ($Uoffice -eq "Berlinn" -and $dept -eq "Judoo"){

    Add-ADGroupMember -Identity 'JudooBerlinn' -Members $login

}
elseif ($Uoffice -eq "Berlinn" -and $dept -eq "Boxes"){

    Add-ADGroupMember -Identity 'BoxesBerlinn' -Members $login
} 

} 

#Ajout des groupes dans les groupes

Add-ADGroupMember -Identity 'MMAA' -Members MMAAPariss,MMAALondress,MMAABerlinn
Add-ADGroupMember -Identity 'Boxes' -Members BoxesPariss,BoxesLondress,BoxesBerlinn
Add-ADGroupMember -Identity 'Tenniss'-Members TennissPariss,TennissLondress,TennissBerlinn
Add-ADGroupMember -Identity 'Judoo' -Members JudooPariss,JudooLondress,JudooBerlinn
