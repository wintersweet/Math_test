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
    NSArray *arr =  @[@(2), @(1), @(5), @(3)];
//    NSArray *newArr = [arr reverseObjectEnumerator].allObjects;
//    NSMutableArray *resourceArr = [NSMutableArray arrayWithArray:arr];
//    NSMutableArray *bubbleArr =  [self bubbleSortWithArray:resourceArr];
    NSMutableArray *xx = [self quickSortArray:[NSMutableArray arrayWithArray:arr] leftIndex:0 rightIndex:arr.count - 1];
    int arrray[5] = { -2, 1, -3 };
    maxSubArray(arrray);
    [self mergeArr:@[@1, @3, @5] arr2:@[@2, @6]];
}

/*
给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
示例:
输入: [-2,1,-3,4,-1,2,1,-5,4]
输出: 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
进阶:*/
int maxSubArray(int arrray[])
{
    int max =  arrray[0];
    int sum = 0;

    int length = sizeof(arrray) / sizeof(int);
    for (int i = 0; i < length; i++) {
        sum = 0;
        for (int j = i; j < length; j++) {
            sum += arrray[j];
            if (sum > max) {
                max = sum;
            }
        }
    }
    return max;
}

/*
给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
str1 = @“helloxxll“;
str2 = @"ll";
*/
- (int)needStirng:(NSString *)str1 str2:(NSString *)str2 {
    if ([str1 containsString:str2]) {
        NSString *temp = [str2 substringToIndex:0];
        for (int i = 0; i < str1.length; i++) {
        }
        NSRange rang = [str1 rangeOfString:str2];

        return 0;
    } else {
        return -1;
    }
}

//删除排序数组中的重复项
//快 慢指针
- (void)printLegnth {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@(1), @(1), @(2), @(3), @(3), nil];
    NSInteger slow = 0;
    NSInteger fast = 0;
    while (fast != array.count) {
        NSNumber *value1 =  array[slow];
        NSNumber *value2 =  array[fast];
        if (value1.intValue == value2.intValue) {
            fast++;
        } else {
            slow++;
            array[slow] = array[fast];
            fast++;
        }
    }
    NSLog(@"slow+1==%ld", slow + 1);
}

//MARK:招...
//1.字符串反转 (头尾双指针，不断交换两个指针的字符即可)
//2. 链表的倒数第 k 个数
//3. 设计求一个数的 n 次开方 (典型的二分题目，不会的建议看下我的二分讲义)
//4. LRU 算法
//5. 手撕一下，就是一个小车给定坐标位置，和当前面朝方向（NSWE），再输入前进转向情况和前进步数，输出小车的坐标位置和面朝方向
//6.链表相加
//7.leetcode 1567 乘积为正数的最长子数组长度
- (void)reserseString:(NSString *)str {
    NSString *result = @"";
    for (NSInteger i = str.length - 1; i >= 0; i--) {
        NSString *temp = [str substringWithRange:NSMakeRange(i, 1)];
        result = [result stringByAppendingString:temp];
    }
    NSLog(@"1");
    char *ca = (char *)[str UTF8String];
//    char_reverse1(ca);
}

//2...字符串反转(和上面不是一个算发)
void char_reverse1(char *cha)
{
    //定义头部指针 尾部指针
    char *begin = cha;
    char *end = cha + strlen(cha) - 1;
    while (begin < end) {
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
    printf("%s", cha);
}

//MARK:招...
/*
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
- (void)selectionSortWithMutableArray:(NSMutableArray *)mutableArray {
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
 快速排序  @[@(2), @(1), @(5), @(3)];
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，
 然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列
 */
- (NSMutableArray *)quickSortArray:(NSMutableArray *)array
                         leftIndex:(NSInteger)left
                        rightIndex:(NSInteger)right
{
    if (left > right) {
        return array;
    }
    NSInteger i = left; // 1
    NSInteger j = right; // 4
    //记录基准数 privoty
    NSInteger key = [array[i] integerValue];
    while (i < j) {
        //首先从右边j开始查找(从最右边往左找)比基准数(key)小的值<---
        while (i < j && key <= [array[j] integerValue])
            j--;
        //如果从右边j开始查找的值array[j]比基准数小，则将查找的小值调换到i的位置

        array[i] = array[j];

        //从i开始往后找比基准数大的值 --->
        while (i < j && [array[i] integerValue] <= key)
            i++;
        //从i的右边往右查找到一个比基准数key小的值时
        //如果从i的右边往右查找的值array[i]比基准数大，则将查找的大值调换到j的位置

        array[j] = array[i];
    }
    array[i] = @(key);
    //递归排序
    //将i左边的数重新排序
    [self quickSortArray:array leftIndex:left rightIndex:i - 1];
    //将i右边的数重新排序
    [self quickSortArray:array leftIndex:i + 1 rightIndex:right];
    return array;
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

+ (void)testSum {
    int sum =  sumAdd(2, 4);
    NSLog(@"相加递归=");
}

//两个数n、m 如果是n= 2 m=5，用递归实现2 3 4 5相加等于14；
int sumAdd(int n1, int n2)
{
    if (n1 == n2) {
        NSLog(@"相加递归1==%d", n1);
        return n1;
    }
    if (n1 > n2) {
        int temp = n1;
        n1 = n2;
        n2 = temp;
    }
    int a = sumAdd(n1, n2 - 1) + n2;
    NSLog(@"相加递归2==%d", a);
    return a;
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

//MARK:3.斐波那契数列
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

int fib(int n)
{
    if (n < 2) {
        return n;
    } else {
        return fib(n - 1) + fib(n - 2);
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

//MARK:使用滑动窗口来解决：滑窗的右边缘在滑窗内没有重复的地方向前移动，
//左边缘在滑窗内没有重复的地方不动，有重复后便进行向右滑动。在此期间每滑动一次就比较窗口的大小
// 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度
// 输入: s = "abcabcbb"
// 输出: 3
// 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3
- (NSInteger)lengthOfLongestSubstring:(NSString *)str {
    NSMutableSet *set = [NSMutableSet set];
    NSInteger left = 0, right = 0, length = 0;
    while (right < str.length) {
        NSString *charStr = [str substringWithRange:NSMakeRange(right, 1)];
        if ([set containsObject:charStr]) {
            NSString *aa = [str substringWithRange:NSMakeRange(left++, 1)];
            [set removeObject:aa];
        } else {
            NSString *aa = [str substringWithRange:NSMakeRange(right++, 1)];
            [set addObject:aa];
        }
        length = set.count > length ? set.count : length;
    }
    return length;
}

//MARK:编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数
//输入 00000000000000000000000000001011  输出：3
- (int)hammingWeight:(int)n {
    int count = 0;
    while (n) {
        count += n % 2;
        n >>= 1;
    }

    return count;
}

//MARK:回文子串
//给定一个字符串，你的任务是计算这个字符串中有多少个回文子串
//具有不同开始位置或结束位置的子串，即使是由相同的字符组成，也会被视作不同的子串
// 输入："abc"输出：3. 解释：三个回文子串: "a", "b", "c"
//输入："aaa" ,输出：6. 解释：6个回文子串: "a", "a", "a", "aa", "aa", "aaa"

//MARK:最长 回文子串
- (void)countSubstrings:(NSString *)str {
    NSInteger count = 0;
}

//MARK:给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效
//有效字符串需满足：
//1.左括号必须用相同类型的右括号闭合。
//2.左括号必须以正确的顺序闭合。
- (bool)isValid:(NSString *)str {
    return true;
}

//MARK: 其他算法
//快速排序、归并排序
//二维数组查找(每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数)
//二叉树的遍历：判断二叉树的层数
//单链表判断环
// [1,5,7]   [3,4]
- (void)mergeArr:(NSArray *)arr1 arr2:(NSArray *)arr2 {
    NSMutableArray *muaArr1 = [NSMutableArray arrayWithArray:arr1];
    NSMutableArray *muaArr2 = [NSMutableArray arrayWithArray:arr2];
    NSInteger m = muaArr1.count - 1;
    NSInteger n = muaArr2.count - 1;
    NSInteger k = m + n - 1;

    while (m >= 1) {
        if (([muaArr1[m] intValue] >= [muaArr2[n] intValue])) {
        } else {
        }
    }

    NSLog(@"结束");
}

void mergeA(int arr1[], int arr2[])
{
}

@end
