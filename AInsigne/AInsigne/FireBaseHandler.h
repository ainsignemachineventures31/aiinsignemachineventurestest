//
//  FireBaseHandler.h
//  AInsigne
//
//  Created by macbook on 4/14/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import <UIKit/UIKit.h>
#import "CrudViewController.h"
@interface FireBaseHandler : NSObject



-(void)addProjects:projName projectDesc:(NSString *)projectDesc projectDuration:(NSString *)projectDuration projLanguage:(NSString *)projLanguage;
-(void)updateProjects:projName projectDesc:(NSString *)projectDesc projectDuration:(NSString *)projectDuration projLanguage:(NSString *)projLanguage;
- (void)deleteProject:(NSString *)projName;



-(void)addUser:fullName firstName:(NSString *)firstName lastName:(NSString *)lastName job:(NSString *)job specialties:(NSString *)specialties userName:(NSString *)userName;
-(void)updUser:fullName firstName:(NSString *)firstName lastName:(NSString *)lastName job:(NSString *)job specialties:(NSString *)specialties userName:(NSString *)userName;
- (void)deleteUser:(NSString *)userName;


- (void)registerUser:userName passWord:(NSString *)passWord cv:(UIViewController *)mainView;
- (void)authUser:userName passWord:(NSString *)passWord cv:(UIViewController *)mainView;

-(void)initFBHandler;
-(void)setUser:userName;
-(void)setProject:userName;

- (void)detectProfile:(NSString *)userName;
- (void)detectProjects:(NSString *)userName;
- (void)detectUser:(NSString *)userName;
- (NSString *)getDetectedUser;
- (NSMutableArray *)getDetectedProjects;
- (NSMutableArray *)getDetectedProfile;
- (void)setDetectedProfile:(NSMutableArray *)dProf;
@end
