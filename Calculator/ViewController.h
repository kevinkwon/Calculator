//
//  ViewController.h
//  Calculator
//
//  Created by hdk on 2014. 6. 13..
//  Copyright (c) 2014년 Kevin Kwon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kStatusCode)
{
    STATUS_DEFAULT = 0,
    STATUS_DIVISION,
    STATUS_MULTIPLY,
    STATUS_MINUS,
    STATUS_PLUS,
    STATUS_RETURN
};

@interface ViewController : UIViewController {
    double curValue;
    double totalCurValue;
    kStatusCode curStatusCode;
    NSString *curInputValue;
    // 결과값 표시를 위한 아웃렛 선언
    UILabel *displayLabel;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (void)Calculation:(kStatusCode)StatusCode CurStatusCode:(kStatusCode)cStatusCode;
- (void)ClearCalculation;
- (void)DisplayInputValue:(NSString *)displayText;
- (void)DisplayCalculationValue;

- (NSString *)ConvertComma:(NSString *)data;

- (void)MinusCalculation;
- (void)PlusCalculation;
- (void)MultiplyCalculation;
- (void)DivisionCalculation;
- (void)remainCalculationValue;
- (void)ReturnCalculationValue;

@property Float64 curValue; // 현재 입력된 값을 프로퍼티로 선언
@property Float64 totalCurValue; // 최종계산값을 프로퍼티로 선언
@property kStatusCode curStatusCode;
@property (nonatomic, retain) NSString *curInputValue;
@property (nonatomic, retain) IBOutlet UILabel *displayLabel;

@end
