/**
 * @author jasonf@nebulaconsulting.co.uk
 * @date 19/04/2021
 */
@JsonAccess(Deserializable='always')
global without sharing class ContactSetDefaultAccount implements nebc.BeforeInsert {
    private static String accountName;

    private static nebc.SObjectIndex defaultAccountsMap {
        get {
            if (defaultAccountsMap == null) {
                defaultAccountsMap = new nebc.SObjectIndex(Account.BillingCountry, Account.Name)
                        .putAll([SELECT Id, Name, BillingCountry FROM Account WHERE Name LIKE :accountName + '%']);
            }
            return defaultAccountsMap;
        } set;
    }

    global void handleBeForeInsert(List<Contact> newList) {
        for (Contact con : newList) {
            if (con.AccountId == null) {
                if (defaultAccountsMap == null) {
                    con.addError('Please associate an account or create an account with name like \"Default Account\"');
                } else {
                    Id defaultAccIdByCountry = getDefaultAccountFromMap('BillingCountry', con.MailingCountry);
                    con.AccountId = defaultAccIdByCountry == null ? getDefaultAccountFromMap('Name', 'Default Account') : defaultAccIdByCountry;
                }
            }
        }
    }

    private static Id getDefaultAccountFromMap(String key, String value) {
        List<Account> accounts = (List<Account>) defaultAccountsMap.getAll(new Map<String, Object>{
                key => value
        });

        if (accounts.size() == 0) {
            return null;
        }

        return accounts[0].Id;
    }
}