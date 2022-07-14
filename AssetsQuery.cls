public without sharing class AssetsQuery {
@AuraEnabled(cacheable=true)
public static Asset[] getAssetsOwnedForEntList(Id recordId, Object entitlementRec) {
System.debug('In getAssetsOwnedForEntList');
    system.debug('entitlementRec'+entitlementRec);
    Map<String,Object> mapObj = (Map<String,Object>)Json.deserializeUntyped(Json.serialize(entitlementRec));
    Map<String,Object> fieldmapObj = (Map<String,Object>)Json.deserializeUntyped(Json.serialize(mapObj.get('fields')));
    system.debug('mapObj'+mapObj);
    Map<String,Object> accfieldmap = (Map<String,Object>)fieldmapObj.get('AccountId');
    Map<String,Object> prodfieldmap = (Map<String,Object>)fieldmapObj.get('Product__c');
    system.debug('value'+accfieldmap.get('value'));
    String accId = (String)accfieldmap.get('value');
    String prodId = (String)prodfieldmap.get('value');

    return [
        SELECT Id, Name, Account.Name, Engine_Model__r.Name, Product2.Name, Operator_lookup__r.Name, Status
        FROM Asset
        WHERE AccountId = :accId AND (Engine_Model__c = :prodId OR Product2Id = :prodId) AND Status <> null
        ORDER BY Name ASC
    ];
}
}
