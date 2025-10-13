Natuurlijk. Hier is de bijgewerkte tabel met de informatie voor de `red` machine toegevoegd.

| Machine | Netwerk | IP-adres | Commando (voor uw host) |
| :--- | :--- | :--- | :--- |
| **isprouter** | Fake Internet | `192.168.62.254` | `ssh vagrant@192.168.62.254` |
| **companyrouter** | Fake Internet | `192.168.62.253` | `ssh vagrant@192.168.62.253` |
| **homerouter** | Fake Internet | `192.168.62.42` | `ssh vagrant@192.168.62.42` |
| **red** | Fake Internet | `192.168.62.100` | `ssh vagrant@192.168.62.100` |
| **dns** | Intern Bedrijfs-LAN | `172.30.0.4` | `ssh -J vagrant@192.168.62.253 vagrant@172.30.0.4` |
| **web** | Intern Bedrijfs-LAN | `172.30.0.10` | `ssh -J vagrant@192.168.62.253 vagrant@172.30.0.10` |
| **remote_employee** | Thuis-LAN | `172.10.10.123` | `ssh -J vagrant@192.168.62.42 vagrant@172.10.10.123` |

