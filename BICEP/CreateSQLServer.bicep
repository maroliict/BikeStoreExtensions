@description('The name of the SQL logical server.')
param serverName string = 'SQLDemoServer'

@description('Specifies region for all resources')
param location string = 'WestEurope'

@description('Specifies sql admin login')
param administratorLogin string = 'RobLitjens'

@description('Specifies sql admin password')
@secure()
param administratorLoginPassword string
@minLength(16)

@description('Specifies managed identity name')
param managedIdentityName string

var sqlDBName = 'BikeStores'

// Data resources
resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2022-05-01-preview' = {
  name: 'AllowAllWindowsAzureIp/1'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}



// Managed Identity resources
resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

resource roleassignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(msi.id, resourceGroup().id, 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  properties: {
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
    principalId: msi.properties.principalId
  }
}

