Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\script\import.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "Ligues" -Path "dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Londres" -Path "ou=Ligues,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Paris" -Path "ou=Ligues,dc=imcsio2,dc=fr"
New-ADOrganizationalUnit -Name "Berlin" -Path "ou=Ligues,dc=imcsio2,dc=fr"

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
        "Paris" {$office = "OU=Paris,OU=Ligues,dc=imcsio2,DC=fr"}
        "Berlin" {$office = "OU=Berlin,OU=Ligues,dc=imcsio2,DC=fr"}
        "Londres" {$office = "OU=Londres,OU=Ligues,dc=imcsio2,DC=fr"}
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

New-ADGroup -Name MMA -GroupScope Global -GroupCategory Security -Path "ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name Boxe -GroupScope Global -GroupCategory Security -Path "ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name Tennis -GroupScope Global -GroupCategory Security -Path "ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name Judo -GroupScope Global -GroupCategory Security -Path "ou=Ligues,dc=imcsio2,dc=fr"

#*********************Groupes sous Paris************************

New-ADGroup -Name MMAParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name BoxeParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name TennisParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name JudoParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Ligues,dc=imcsio2,dc=fr"

#*********************Groupes sous Londres************************

New-ADGroup -Name MMALondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name BoxeLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name TennisLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name JudoLondres -GroupScope Global -GroupCategory Security -Path "ou=Londres,ou=Ligues,dc=imcsio2,dc=fr"

#*********************Groupes sous Berlin************************

New-ADGroup -Name MMABerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name BoxeBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name TennisBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Ligues,dc=imcsio2,dc=fr"
New-ADGroup -Name JudoBerlin -GroupScope Global -GroupCategory Security -Path "ou=Berlin,ou=Ligues,dc=imcsio2,dc=fr"

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

if ($Uoffice -eq "Paris" -and $dept -eq "MMA"){

    Add-ADGroupMember -Identity 'MMAParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Tennis"){

    Add-ADGroupMember -Identity 'TennisParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Judo"){

    Add-ADGroupMember -Identity 'JudoParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Boxe"){

    Add-ADGroupMember -Identity 'BoxeParis' -Members $login
} 

#********Ajout des utilisateurs de Londres dans leurs groupes********************

if ($Uoffice -eq "Londres" -and $dept -eq "MMA"){

    Add-ADGroupMember -Identity 'MMALondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Tennis"){

    Add-ADGroupMember -Identity 'TennisLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Judo"){

    Add-ADGroupMember -Identity 'JudoLondres' -Members $login

}
elseif ($Uoffice -eq "Londres" -and $dept -eq "Boxe"){

    Add-ADGroupMember -Identity 'BoxeLondres' -Members $login
} 
#********Ajout des utilisateurs de Berlin dans leurs groupes********************

if ($Uoffice -eq "Berlin" -and $dept -eq "MMA"){

    Add-ADGroupMember -Identity 'MMABerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Tennis"){

    Add-ADGroupMember -Identity 'TennisBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Judo"){

    Add-ADGroupMember -Identity 'JudoBerlin' -Members $login

}
elseif ($Uoffice -eq "Berlin" -and $dept -eq "Boxe"){

    Add-ADGroupMember -Identity 'BoxeBerlin' -Members $login
} 

} 

#Ajout des groupes dans les groupes

Add-ADGroupMember -Identity 'MMA' -Members MMAParis,MMALondres,MMABerlin
Add-ADGroupMember -Identity 'Boxe' -Members BoxeParis,BoxeLondres,BoxeBerlin
Add-ADGroupMember -Identity 'Tennis'-Members TennisParis,TennisLondres,TennisBerlin
Add-ADGroupMember -Identity 'Judo' -Members JudoParis,JudoLondres,JudoBerlin
