//
//  FormularioContatoControllerViewController.h
//  FirstContacts
//
//  Created by ios2686 on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoProtocol.h"

@interface FormularioContatoControllerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;

@property (strong,nonatomic) id<ContatoProtocol> delegate;

@end
