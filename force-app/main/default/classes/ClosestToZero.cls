/**
 * @author jasonf@nebulaconsulting.co.uk
 * @date 21/04/2021
 * @description (if required)
 */

public with sharing class ClosestToZero {

    public static Integer getClosestToZero(List<Integer> intList) {
        if (intList.size() == 0) {
            return null;
        }

        intList = addZeroSortAndRemoveDupes(intList);

        Integer closestToZero = null;
        Integer count = 0;

        for (Integer i : intList) {
            if (i == 0) {
                if (count == 0) {
                    closestToZero = intList[1];
                    break;
                }

                if (count + 1 == intList.size()) {
                    closestToZero = intList[count - 1];
                    break;
                }
            }

            if (i == 0) {
                break;
            }

            count++;
        }

        if (closestToZero == null) {
            Integer beforeZero = intList[count - 1];
            Integer afterZero = intList[count + 1];

            if (Math.abs(beforeZero) == afterZero) {
                return null;
            }

            closestToZero = Math.abs(beforeZero) > afterZero ? afterZero : beforeZero;
        }

        return closestToZero;
    }

    private static List<Integer> addZeroSortAndRemoveDupes(List<Integer> intList) {
        Set<Integer> intSet = new Set<Integer>();
        List<Integer> deDupeList = new List<Integer>();

        intList.add(0);
        intList.sort();

        intSet.addAll(intList);
        deDupeList.addAll(intSet);

        return deDupeList;
    }
}