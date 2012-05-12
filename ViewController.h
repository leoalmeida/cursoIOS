//
//  ViewController.h
//  FirstContacts
//
//  Created by ios2686 on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoProtocol.h"
#import "MessageUI/MFMailComposeViewController.h"
#import "Twitter/TWTweetComposeViewController.h"

@interface ViewController : UITableViewController <ContatoProtocol, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property(strong, nonatomic) NSMutableArray *contatos; 
@property(strong, nonatomic) Contato *contatoSelecionado;
-(void) exibeMaisAcoes:(UIGestureRecognizer *)gesto;

@end
