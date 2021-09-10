/**
 * @author jasonf@nebulaconsulting.co.uk
 * @date 19/04/2021
 */

@IsTest
private class ContactSetDefaultAccountTest {
    private static nebc.TestRecordSource testRecordSource = new nebc.TestRecordSource();

    @IsTest
    static void newContactWithAccTest() {
        testRecordSource.getRecord(Contact.SObjectType)
                .asVariant('With Default Acc')
                .withInsert();

        System.assertEquals(getAccountIdByName('Test Account'), getContacts()[0].AccountId);
    }

    @IsTest
    static void newContactWithoutAccTest() {
       testRecordSource.getRecord(Account.SObjectType)
               .put(Account.Name, 'Default Account')
               .withInsert();

       testRecordSource.getRecord(Contact.SObjectType)
               .withInsert();

       System.assertEquals(getAccountIdByName('Default Account'), getContacts()[0].AccountId);
    }

    @IsTest
    static void newContactEnglandWithoutAccTest() {
        Account defaultAcc = (Account) testRecordSource.getRecord(Account.SObjectType)
                .put(Account.Name, 'Default Account')
                .withoutInsert();

        insert defaultAcc;

        testRecordSource.getRecord(Account.SObjectType)
                .put(Account.Name, 'Default Account England')
                .put(Account.BillingCountry, 'England')
                .withInsert();

        testRecordSource.getRecord(Contact.SObjectType)
                .put(Contact.MailingCountry, 'England')
                .withInsert();

        // Despite more than 1 `Default Account` present; because the contact is associated with `England`
        // the correct default account by country should be selected.
        System.assertEquals(getAccountIdByName('Default Account England'), getContacts()[0].AccountId);
    }

    @IsTest
    static void newContactsWithoutAccEnMasseTest() {
        Account acc = (Account) testRecordSource.getRecord(Account.SObjectType)
                .put(Account.Name, 'Default Account')
                .withInsert();

        testRecordSource.getRecord(Contact.SObjectType)
                .withInsert(10);

        for (Contact c : getContacts()) {
            System.assertEquals(acc.Id, c.AccountId);
        }
    }

    @IsTest
    static void newContactWithErrorTest() {
        try {
            testRecordSource.getRecord(Contact.SObjectType)
                    .withInsert();
        } catch (Exception e) {
            e.getMessage().contains('Please associate an account or create an account with name like \"Default Account\"');
        }
    }

    private static Id getAccountIdByName(String accName) {
        return [SELECT Id FROM Account WHERE Name = :accName].Id;
    }

    private static List<Contact> getContacts() {
        return [SELECT AccountId FROM Contact];
    }
}