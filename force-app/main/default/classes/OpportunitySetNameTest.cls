/**
 * @author danb@nebulaconsulting.co.uk
 * @date 20/04/2021
 */

@IsTest
private class OpportunitySetNameTest {
    private static nebc.TestRecordSource testRecordSource = new nebc.TestRecordSource();

    @IsTest
    static void testBehavior() {
        Opportunity testOpportunity = (Opportunity) testRecordSource.getRecord(Opportunity.SObjectType)
                .asVariant('New Business')
                .withoutInsert();

        System.assertEquals('My Opportunity', testOpportunity.Name);
        System.assertNotEquals(null, testOpportunity.Description);
        System.assertEquals(Date.today().addDays(-5), testOpportunity.CloseDate);
    }
}