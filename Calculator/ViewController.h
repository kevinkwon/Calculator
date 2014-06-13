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
    kStatusCodeDefault = 0,
    kStatusCodeDivision,
    kStatusCodeMultiply,
    kStatusCodeMinus,
    kStatusCodePlus,
    kStatusCodeReturn
};

@interface ViewController : UIViewController {
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (void)calculation:(kStatusCode)StatusCode curStatusCode:(kStatusCode)cStatusCode;
- (void)clearCalculation;
- (void)displayInputValue:(NSString *)displayText;
- (void)displayCalculationValue;

- (NSString *)ConvertComma:(NSString *)data;

- (void)minusCalculation;
- (void)plusCalculation;
- (void)multiplyCalculation;
- (void)divisionCalculation;
- (void)remainCalculationValue;
- (void)returnCalculationValue;

@property Float64 curValue; // 현재 입력된 값을 프로퍼티로 선언
@property Float64 totalCurValue; // 최종계산값을 프로퍼티로 선언
@property kStatusCode curStatusCode;
@property (nonatomic, retain) NSString *curInputValue;
@property (nonatomic, retain) IBOutlet UILabel *displayLabel;

@end
