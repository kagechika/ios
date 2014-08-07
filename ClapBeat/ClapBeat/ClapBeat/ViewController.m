//
//  ViewController.m
//  ClapBeat
//
//  Created by okitokagechika on 2014/04/06.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    Clap *clapInstance;
    IBOutlet UIPickerView *PickerView;
    NSString *repeatNumbersForPicker [10];
    int repeatCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    clapInstance = [Clap initClap];
    
    repeatCount = 1;
    
    for (int i=0; i<10; i++) {
        NSString *numberText = [NSString stringWithFormat:@"%d回", i+1];
        repeatNumbersForPicker[i] = numberText;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return repeatNumbersForPicker[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    repeatCount = row + 1;
}

-(IBAction)play:(id)sender
{
    [clapInstance repeatClap:repeatCount];
}

@end
