//
//  ViewController.m
//  AInsigne
//
//  Created by macbook on 4/14/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

FireBaseHandler *fbh;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fbh = [[FireBaseHandler alloc]init];
    [fbh initFBHandler];
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    if(fbh!=nil && _userField!=nil && _passField!=nil)
    {
        [fbh authUser:_userField.text passWord:_passField.text cv:self];
    }
}

- (IBAction)signUp:(id)sender {
    if(fbh!=nil && _userField!=nil && _passField!=nil)
    {
        [fbh registerUser:_userField.text passWord:_passField.text cv:self];
    }
}
@end
