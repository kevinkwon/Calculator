//
//  ViewController.m
//  Calculator
//
//  Created by hdk on 2014. 6. 13..
//  Copyright (c) 2014년 Kevin Kwon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self clearCalculation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (IBAction)digitPressed:(UIButton *)sender
{
    NSString *numPoint = [[sender titleLabel] text];
//    if ([@"∙" isEqualToString:sender.titleLabel.text])
//    {
//        [self Calculation:curStatusCode CurStatusCode:kStatusCodePlus];
//        numPoint = @".";
//    }
//    else {
//        numPoint = [[sender titleLabel]text];
//    }
    self.curInputValue = [self.curInputValue stringByAppendingString:numPoint];
    [self displayInputValue:self.curInputValue];
}

- (IBAction)operationPressed:(UIButton *)sender
{
    NSString *operationText = [[sender titleLabel] text];
    
    if ([@"+" isEqualToString:operationText])
    {
        [self calculation:self.curStatusCode curStatusCode:kStatusCodePlus];
    }
    else if([@"−" isEqualToString:operationText])
    {
        [self calculation:self.curStatusCode curStatusCode:kStatusCodeMinus];
    }
    else if([@"×" isEqualToString:operationText])
    {
        [self calculation:self.curStatusCode curStatusCode:kStatusCodeMultiply];
    }
    else if([@"÷" isEqualToString:operationText])
    {
        [self calculation:self.curStatusCode curStatusCode:kStatusCodeDivision];
    }
    else if([@"C" isEqualToString:operationText])
    {
        [self clearCalculation];
    }
    else if([@"=" isEqualToString:operationText])       // 계산
    {
        [self calculation:self.curStatusCode curStatusCode:kStatusCodeReturn];
    }
}

- (void)calculation:(kStatusCode)StatusCode curStatusCode:(kStatusCode)cStatusCode
{
    switch(StatusCode)
    {
        case kStatusCodeDefault:
            [self defaultCalculation];
            break;
        case kStatusCodeDivision:
            [self divisionCalculation];
            break;
        case kStatusCodeMultiply:
            [self multiplyCalculation];
            break;
        case kStatusCodeMinus:
            [self minusCalculation];
            break;
        case kStatusCodePlus:
            [self plusCalculation];
            break;
        default:
            break;
    }
    self.curStatusCode = cStatusCode;
}

- (void)clearCalculation
{
    self.curInputValue = @"";
    self.curValue = 0;
    self.totalCurValue = 0;
    
    [self displayInputValue:self.curInputValue];
    
    self.curStatusCode = kStatusCodeDefault;
}

- (void)displayInputValue:(NSString *)displayText
{
    NSString *CommaText;
    CommaText = [self ConvertComma:displayText];
    [self.displayLabel setText:CommaText];
}

- (void)displayCalculationValue
{
    NSString *displayText;
    displayText = [NSString stringWithFormat:@"%g", self.totalCurValue];
    [self displayInputValue:displayText];
    self.curInputValue = @"";
}


- (NSString *)ConvertComma:(NSString *)data
{
    NSString *minusString = nil;
    NSString *integerString = nil;
    NSString *floatString = nil;

    if (data == nil) return nil;
    if ([data length] <= 3) return data;
    
    // 소수점을 찾기
    NSRange pointRange = [data rangeOfString:@"."];
    if (pointRange.location == NSNotFound) {
        // 소수점이 없다.
        integerString = data;
    }
    else {
        // 소수점 이하
        NSRange r;
        r.location = pointRange.location;
        r.length = [data length] - pointRange.location;
        floatString = [data substringWithRange:r];
        
        // 정수부
        r.location = 0;
        r.length = pointRange.location;
        integerString = [data substringWithRange:r];
    }
    
    // 음수 부호를 찾기
    NSRange minusRange = [integerString rangeOfString:@"-"];
    if ( minusRange.location != NSNotFound ) { // 음수 부호가 있다.
        minusString = @"-";
        integerString = [integerString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    // 세자리 단위로 콤마를 찍기
    NSMutableString *integerStringCommaInserted = [[NSMutableString alloc] init];
    int integerStringLength = [integerString length];
    int idx = 0;
    while (idx < integerStringLength) {
        [integerStringCommaInserted appendFormat:@"%C", [integerString characterAtIndex:idx]];
        if ((integerStringLength - (idx+1)) % 3 == 0 && integerStringLength != (idx + 1)) {
            [integerStringCommaInserted appendString:@","];
        }
        idx++;
    }
    
    NSMutableString *returnString = [[NSMutableString alloc] init];
    if (minusString != nil) [returnString appendString:minusString];
    if (integerStringCommaInserted != nil) [returnString appendString:integerStringCommaInserted];
    if (floatString != nil) [returnString appendString:floatString];
    
    return returnString;
}

- (void)defaultCalculation
{
    self.curValue = [self.curInputValue doubleValue];
    self.totalCurValue = self.curValue;
    [self displayCalculationValue];
}

- (void)plusCalculation
{
    self.curValue = [self.curInputValue doubleValue];
    self.totalCurValue = self.totalCurValue + self.curValue;
    [self displayCalculationValue];
}

- (void)minusCalculation
{
    self.curValue = [self.curInputValue doubleValue];
    self.totalCurValue = self.totalCurValue - self.curValue;
    [self displayCalculationValue];
}

- (void)multiplyCalculation
{
    self.curValue = [self.curInputValue doubleValue];
    self.totalCurValue = self.totalCurValue * self.curValue;
    [self displayCalculationValue];
}

- (void)divisionCalculation
{
    self.curValue = [self.curInputValue doubleValue];
    self.totalCurValue = self.totalCurValue / self.curValue;
    [self displayCalculationValue];
}

@end
