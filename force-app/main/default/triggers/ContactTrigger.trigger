/**
 * @author jasonf@nebulaconsulting.co.uk
 * @date 19/04/2021
 */

trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new nebc.MetadataTriggerManager(Contact.SObjectType).handle();
}