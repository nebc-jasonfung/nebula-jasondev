/**
 * @author jasonf@nebulaconsulting.co.uk
 * @date 21/04/2021
 * @description (if required)
 */

@IsTest
private class ClosestToZeroTest {
    @IsTest
    static void positiveValuesTest() {
        Integer result = ClosestToZero.getClosestToZero(new List<Integer>{5, 6, 10, 56, 8, 9});
        System.assertEquals(5, result);
    }

    @IsTest
    static void negativeValuesTest() {
        Integer result = ClosestToZero.getClosestToZero(new List<Integer>{-5, -6, -10, -56, -8, -9});
        System.assertEquals(-5, result);
    }

    @IsTest
    static void mixedValuesTest() {
        Integer result = ClosestToZero.getClosestToZero(new List<Integer>{7, -4, -3, 10, 54, -16});
        System.assertEquals(-3, result);
    }

    @IsTest
    static void equalProximityTest() {
        Integer result = ClosestToZero.getClosestToZero(new List<Integer>{7, -4, -3, 10, 3, -16});
        System.assertEquals(null, result);
    }

    @IsTest
    static void dupesTest() {
        Integer result = ClosestToZero.getClosestToZero(new List<Integer>{-3, -3, 0, 0, 2, 2});
        System.assertEquals(2, result);
    }

    @IsTest
    static void emptyListTest() {
        Integer result = ClosestToZero.getClosestToZero(new List<Integer>{});
        System.assertEquals(null, result);
    }
}