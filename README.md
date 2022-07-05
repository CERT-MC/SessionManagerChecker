# SessionManagerChecker
Recherche simple d'IOC du module malveillant Exchange/IIS SessionManager suite à une compromission par ProxyLogon.

Le script nécessite des privilèges d'exécution du composant Powershell Exchange ( Microsoft.Exchange.Management.Powershell.Snapin ).
Il est donc nécessaire d'être Administrateur Exchange et le lancer depuis un serveur Exchange.

Le script se connecte aux différents autres serveurs via SMB pour exécuter les mêmes tests.

Le script produit un rapport (qui est une copie de son affichage) dans un répertoire créé sur le bureau "SessionManagerChecker".

Source des IOCs:  https://securelist.com/the-sessionmanager-iis-backdoor/106868/
