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

@synthesize curValue;
@synthesize totalCurValue;
@synthesize curInputValue;
@synthesize curStatusCode;
@synthesize displayLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self ClearCalculation];
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
//        [self Calculation:curStatusCode CurStatusCode:STATUS_PLUS];
//        numPoint = @".";
//    }
//    else {
//        numPoint = [[sender titleLabel]text];
//    }
    curInputValue = [curInputValue stringByAppendingString:numPoint];
    [self DisplayInputValue:curInputValue];
}

- (IBAction)operationPressed:(UIButton *)sender
{
    NSString *operationText = [[sender titleLabel] text];
    
    if ([@"+" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_PLUS];
    }
    else if([@"−" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_MINUS];
    }
    else if([@"×" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_MULTIPLY];
    }
    else if([@"÷" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_DIVISION];
    }
    else if([@"C" isEqualToString:operationText])
    {
        [self ClearCalculation];
    }
    else if([@"=" isEqualToString:operationText])       // 계산
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_RETURN];
    }
}

- (void)Calculation:(kStatusCode)StatusCode CurStatusCode:(kStatusCode)cStatusCode
{
    switch(StatusCode)
    {
        case STATUS_DEFAULT:
        case STATUS_RETURN:
            [self DefaultCalculation];
            break;
        case STATUS_DIVISION:
            [self DivisionCalculation];
            break;
        case STATUS_MULTIPLY:
            [self MultiplyCalculation];
            break;
        case STATUS_MINUS:
            [self MinusCalculation];
            break;
            
        case STATUS_PLUS:
            [self PlusCalculation];
            break;
    }
    curStatusCode = cStatusCode;
}

- (void)ClearCalculation
{
    curInputValue = @"";
    curValue = 0;
    totalCurValue = 0;
    
    [self DisplayInputValue:curInputValue];
    
    curStatusCode = STATUS_DEFAULT;
}

- (void)DisplayInputValue:(NSString *)displayText
{
    NSString *CommaText;
    CommaText = [self ConvertComma:displayText];
    [displayLabel setText:CommaText];
}

- (void)DisplayCalculationValue
{
    NSString *displayText;
    displayText = [NSString stringWithFormat:@"%g", totalCurValue];
    [self DisplayInputValue:displayText];
    curInputValue = @"";
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

- (void)DefaultCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = curValue;
    [self DisplayCalculationValue];
}

- (void)MinusCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue - curValue;
    [self DisplayCalculationValue];
}

- (void)PlusCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue + curValue;
    [self DisplayCalculationValue];
}

- (void)MultiplyCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue * curValue;
    [self DisplayCalculationValue];
}

- (void)DivisionCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue / curValue;
    [self DisplayCalculationValue];
}

- (void)ReturnCalculationValue
{
    totalCurValue = 0;
}

@end
