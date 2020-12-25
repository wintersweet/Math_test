//
//  MathTest.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/8.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "MathTest.h"
@interface MathTest ()

@property (nonatomic, strong) NSMutableArray *mTempArr;
@end

@implementation MathTest
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)testFunction
{
    NSArray *arr =  @[@(7), @(10), @(5), @(15), @(8)];
    NSArray *newArr = [arr reverseObjectEnumerator].allObjects;
    NSMutableArray *resourceArr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *bubbleArr =  [self bubbleSortWithArray:resourceArr];
    [self quickSortArray:resourceArr leftIndex:0 rightIndex:resourceArr.count - 1];
}

/**
*  【冒泡排序】：相邻元素两两比较，比较完一趟，最值出现在末尾
*  第1趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第n个元素位置
*  第2趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第n-1个元素位置
*   ……   ……
*  第n-1趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第2个元素位置
*/
- (NSMutableArray *)bubbleSortWithArray:(NSMutableArray *)array {
    for (int i = 0; i < array.count - 1; i++) {
        //外层for循环控制循环次数
        for (int j = 0; j < array.count - 1 - i; j++) {
            //内层循环交换数据
            if ([[array objectAtIndex:j] integerValue] > [[array objectAtIndex:j + 1] integerValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    return array;
}

- (void)_bubbleSortWithArray:(NSMutableArray *)array {
    for (int i = 0; i < array.count - 1; i++) {
        for (int j = 0; j < array.count - 1 - i; j++) {
            if ([array[j] intValue] > [array[j + 1] index]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
}

/**
 选择排序  每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，直到全部待排序的数据元素排完。
 *  【选择排序】：最值出现在起始端
 *
 *  第1趟：在n个数中找到最小(大)数与第一个数交换位置
 *  第2趟：在剩下n-1个数中找到最小(大)数与第二个数交换位置
 *  重复这样的操作...依次与第三个、第四个...数交换位置
 *  第n-1趟，最终可实现数据的升序（降序）排列。
 *
 */
- (void)selectionSortWithMutableArray:(NSMutableArray *)mutableArray{
    for (int i = 0; i < mutableArray.count; i++) {
        int index = i;

        for (int j = i + 1; j < mutableArray.count; j++) {
            if ([mutableArray[index] integerValue] > [mutableArray[j] integerValue]) {
                index = j;
            }
        }

        if (index != i) {
            NSString *temp = mutableArray[i];
            mutableArray[i] = mutableArray[index];
            mutableArray[index] = temp;
        }
    }
    NSLog(@"选择排序结果：%@", mutableArray);
}

/**
 快速排序
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，
 然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列
 */
- (void)quickSortArray:(NSMutableArray *)array
             leftIndex:(NSInteger)left
            rightIndex:(NSInteger)right
{
    if (left > right) {
        return;
    }
    NSInteger i = left;
    NSInteger j = right;
    //记录基准数 privoty
    NSInteger key = [array[i] integerValue];
    while (i < j) {
        //首先从右边j开始查找(从最右边往左找)比基准数(key)小的值<---
        while (i < j && key <= [array[j] integerValue])
            j--;
        //如果从右边j开始查找的值[array[j] integerValue]比基准数小，则将查找的小值调换到i的位置
        if (i < j) {
            array[i] = array[j];
        }
        //从i的右边往右查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 --->
        while (i < j && [array[i] integerValue] <= key)
            i++;
        //如果从i的右边往右查找的值[array[i] integerValue]比基准数大，则将查找的大值调换到j的位置
        if (i < j) {
            array[j] = array[i];
        }
    }
    array[i] = @(key);
    //递归排序
    //将i左边的数重新排序
    [self quickSortArray:array leftIndex:left rightIndex:i - 1];
    //将i右边的数重新排序
    [self quickSortArray:array leftIndex:i + 1 rightIndex:right];
}

/**
 归并排序
 归并过程为：比较a[i]和b[j]的大小，若a[i]≤b[j]，则将第一个有序表中的元素a[i]复制到r[k]中，并令i和k分别加上1；否则将第二个有序表中的元素b[j]复制到r[k]中，并令j和k分别加上1，如此循环下去，直到其中一个有序表取完，然后再将另一个有序表中剩余的元素复制到r中从下标k到下标t的单元。归并排序的算法我们通常用递归实现，先把待排序区间[s,t]以中点二分，接着把左边子区间排序，再把右边子区间排序，最后把左区间和右区间用一次归并操作合并成有序的区间[s,t]。
 */
/**
 归并排序
 @param mutableArray 排序数组
 @param low 最低索引
 @param high 最高索引
 */
- (void)mergeSortWithMutableArray:(NSMutableArray *)mutableArray lowIndex:(NSInteger)low highIndex:(NSInteger)high {
    if (high <= low) {
        return;
    }
    NSInteger mid = low + (high - low) / 2;
    [self mergeSortWithMutableArray:mutableArray lowIndex:low highIndex:mid];//左半部分排序
    [self mergeSortWithMutableArray:mutableArray lowIndex:mid + 1 highIndex:high];//右半部分排序
    [self mergeWithMutableArray:mutableArray lowIndex:low highIndex:high midIndex:mid];
}

- (void)mergeWithMutableArray:(NSMutableArray *)mutableArray lowIndex:(NSInteger)low highIndex:(NSInteger)high midIndex:(NSInteger)mid {
    NSInteger i = low, j = mid + 1;
    for (NSInteger k = low; k <= high; k++) {
        self.mTempArr[k] = mutableArray[k];
    }

    for (NSInteger k = low; k <= high; k++) {
        //左边的元素已经取完，取右半边的元素
        if (i > mid) {
            mutableArray[k] = self.mTempArr[j++];
        }
        //右边的元素已经取完，取左边的元素
        else if (j > high) {
            mutableArray[k] = self.mTempArr[i++];
        }
        //如果索引j的值大,那么取左边的值
        else if ([self.mTempArr[j] integerValue] < [self.mTempArr[i] integerValue]) {
            mutableArray[k] = self.mTempArr[j++];
        } else {
            mutableArray[k] = self.mTempArr[i++];
        }
    }
}

/**
 二分法查找
 假设表中元素是按升序排列，将表中间位置记录的关键字与查找关键字比较，如果两者相等，则查找成功；否则利用中间位置记录将表分成前、后两个子表，如果中间位置记录的关键字大于查找关键字，则进一步查找前一子表，否则进一步查找后一子表。重复以上过程，直到找到满足条件的记录，使查找成功，或直到子表不存在为止，此时查找不成功。
 @param orderArray 遍历的数组对象 (要求数组是有序的)
 @param target 目标值
 @return 返回目标值在数组中的 index，如果没有返回 -1
 */
- (NSUInteger)binarySearchWithArray:(NSArray *)orderArray target:(NSInteger)target
{
    if (!orderArray.count) {
        return -1;
    }
    NSUInteger low = 0;
    NSUInteger high = orderArray.count - 1;

    while (low <= high) {
        NSUInteger mid = low + (high - low) / 2;
        NSInteger num = [[orderArray objectAtIndex:mid] integerValue];
        if (target == num) {
            return mid;
        } else if (num > target) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return -1;
}

/**
 *  折半查找：优化查找时间（不用遍历全部数据）
 *
 *  折半查找的原理：
 *   1> 数组必须是有序的
 *   2> 必须已知min和max（知道范围）
 *   3> 动态计算mid的值，取出mid对应的值进行比较
 *   4> 如果mid对应的值大于要查找的值，那么max要变小为mid-1
 *   5> 如果mid对应的值小于要查找的值，那么min要变大为mid+1
 */
// 已知一个有序数组, 和一个key, 要求从数组中找到key对应的索引位置
int findKey(int *arr, int length, int key)
{
    int min = 0, max = length - 1, mid;
    while (min <= max) {
        mid = (min + max) / 2; //计算中间值
        if (key > arr[mid]) {
            min = mid + 1;
        } else if (key < arr[mid]) {
            max = mid - 1;
        } else {
            return mid;
        }
    }
    return -1;
}

/**辗转相除法,更相减损法
 最大公约数
 @param num1 整数1
 @param num2 整数2
 @return 返回两个整数的最大公约数
 */
- (NSInteger)gcdWithNumber1:(NSInteger)num1 Number2:(NSInteger)num2 {
    while (num1 != num2) {
        if (num1 > num2) {
            num1 = num1 - num2;
        } else {
            num2 = num2 - num1;
        }
    }
    return num1;
}

/**
 最小公倍数
 @param num1 整数1
 @param num2 整数2
 @return 返回两个整数的最小公倍数
 */
- (NSInteger)lcmWithNumber1:(NSInteger)num1 Number2:(NSInteger)num2 {
    NSInteger gcd = [self gcdWithNumber1:num1 Number2:num2];
    // 最小公倍数 = 两整数的乘积 ÷ 最大公约数
    return num1 * num2 / gcd;
}

//1、给定一个字符串，输出本字符串中只出现一次并且最靠前的那个字符的位置？如“abaccddeeef”,字符是b,输出应该是2
- (void)function1
{
    NSString *str = @"abacxcdbdeeef";
    NSInteger count = str.length;
    for (NSInteger i = 0; i < count; i++) {
        NSRange range1 = NSMakeRange(i, 1);
        NSString *str1 = [str substringWithRange:range1];
        NSInteger xx = 0;
        for (NSInteger j = 0; j < count; j++) {
            NSRange range2 = NSMakeRange(j, 1);
            NSString *str2 = [str substringWithRange:range2];
            if ([str1 isEqualToString:str2]) {
                xx++;
            }
        }
        if (xx == 1) {
            NSLog(@"当前的字符是==%@", str1);
            NSLog(@"当前的position是==%ld", i);
            break;
        }
    }
}

//2。求2到100内的素数（质数）
- (void)primeNumber
{
    NSMutableArray *primeNumberArray = [NSMutableArray array];
    for (int i = 2; i <= 100; i++) {
        NSInteger n = 0;
        for (int j = 1; j <= i; j++) {
            if (i % j == 0) {
                n = n + 1;
            }
        }

        if (n == 2) {
            [primeNumberArray addObject:@(i)];
        }
    }

    NSLog(@"primeNumber = %@", primeNumberArray);
}

//3.斐波那契数列
/**
 斐波那契数列递归调用，指数级增长2^n
 */
- (NSUInteger)Fibonacci:(NSUInteger)n {
    if (n < 2) {
        return n;
    } else {
        return [self Fibonacci:n - 1] + [self Fibonacci:n - 2];
    }
}

//用数组保存之前计算过的结果，减少大量重复计算，这样算法复杂度优化为 O(n)。
- (NSUInteger)Fibonacci2:(NSUInteger)n {
    if (n < 2) {
        return n;
    } else {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:n + 1];
        array[0] = @(0);
        array[1] = @(1);

        for (int i = 2; i < array.count; i++) {
            array[i] = @([array[i - 1] unsignedIntegerValue] + [array[i - 2] unsignedIntegerValue]);
        }

        return [array[n] unsignedIntegerValue];
    }
}

//同样是斐波那契数列，由于实际只有前两个计算结果有用，我们可以使用中间变量来存储，这样就不用创建数组以节省空间。同样算法复杂度优化为 O(n)。
- (NSUInteger)Fibonacci3:(NSUInteger)n {
    //    NSDate *now1 = [NSDate date];
    if (n < 2) {
        return n;
    } else {
        NSUInteger a = 0, b = 1;
        for (int i = 1; i < n; i++) {
            b = a + b;
            a = b - a;
        }
        //        NSLog(@"fb3耗时：%lf", [now1 timeIntervalSinceNow]);
        return b;
    }
}

@end
