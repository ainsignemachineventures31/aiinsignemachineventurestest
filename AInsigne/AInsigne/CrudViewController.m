//
//  CrudViewController.m
//  AInsigne
//
//  Created by macbook on 4/14/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import "CrudViewController.h"

@interface CrudViewController ()

@end

@implementation CrudViewController
FireBaseHandler *crudfbh;
NSMutableArray *profileDetected;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initFBH];
    [self disableAll];
    [self detectUser];
    [self detectProfile];


    
}

- (void)initFBH
{
    crudfbh = [[FireBaseHandler alloc]init];
    [crudfbh initFBHandler];
    [crudfbh detectUser:_userName];
}

- (void)detectUser
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if([crudfbh getDetectedUser]!=nil)
        {
            [crudfbh setUser:_userName];
            [crudfbh detectProfile:_userName];
        }
    });

}
- (void)detectProfile
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 8 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if([crudfbh getDetectedProfile]!=nil && [[crudfbh getDetectedProfile] count] > 2)
        {

            profileDetected = [crudfbh getDetectedProfile];
            _firstNameField.text = profileDetected[0];
            _lastNameField.text = profileDetected[1];
            _jobField.text = profileDetected[2];
            _specialtiesField.text = profileDetected[3];
            [self disableButton:_updBtn disable:NO];
            [self disableButton:_delBtn disable:NO];
        }
        else
        {
            [self disableButton:_createBtn disable:NO];
        }
    });
}

- (void)refreshProfile
{
    profileDetected = [[NSMutableArray alloc]init];
    [profileDetected addObject:_firstNameField.text];
    [profileDetected addObject:_lastNameField.text];
    [profileDetected addObject:_jobField.text];
    [profileDetected addObject:_specialtiesField.text];
}

- (IBAction)goBack:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"                        bundle:nil];
    ViewController *cv = [storyboard instantiateViewControllerWithIdentifier:@"viewcont"];

    [self presentViewController:cv animated:NO completion:nil];
}

- (IBAction)viewProj:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"                        bundle:nil];
    ProjectsViewController *cv = [storyboard instantiateViewControllerWithIdentifier:@"projectcont"];
    cv.userName = _userName;
    [self presentViewController:cv animated:NO completion:nil];
}

- (void)refreshFields
{
    profileDetected = [[NSMutableArray alloc]init];
     _firstNameField.text = @"";
     _lastNameField.text = @"";
     _jobField.text = @"";
     _specialtiesField.text = @"";
}

- (void)disableAll
{
    [self disableButton:_createBtn disable:YES];
    [self disableButton:_updBtn disable:YES];
    [self disableButton:_delBtn disable:YES];
}

- (void)disableButton:(UIButton *)btn disable:(BOOL)disable
{
    [btn setEnabled:!disable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)update:(id)sender {
    [crudfbh updUser:_userName firstName:_firstNameField.text   lastName:_lastNameField.text job:_jobField.text     specialties:_specialtiesField.text  userName:_userName];
}

- (IBAction)create:(id)sender {
    [crudfbh addUser:_userName firstName:_firstNameField.text   lastName:_lastNameField.text job:_jobField.text     specialties:_specialtiesField.text  userName:_userName];
    [self disableButton:_createBtn disable:YES];
    [self disableButton:_delBtn disable:NO];
    [self disableButton:_updBtn disable:NO];
}

- (IBAction)del:(id)sender {
    [crudfbh deleteUser:_userName];
    [self refreshFields];
    [self disableButton:_createBtn disable:NO];
    [self disableButton:_delBtn disable:YES];
    [self disableButton:_updBtn disable:YES];
}
@end
