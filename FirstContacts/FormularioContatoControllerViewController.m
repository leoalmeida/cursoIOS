//
//  FormularioContatoControllerViewController.m
//  FirstContacts
//
//  Created by ios2686 on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoControllerViewController.h"
#import "Contato.h"

@interface FormularioContatoControllerViewController ()

@end

@implementation FormularioContatoControllerViewController
@synthesize nome;
@synthesize email;
@synthesize telefone;
@synthesize endereco;
@synthesize site;
@synthesize foto;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Adicionar";
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(cancelaForm)];
    btnBack.title = @"Voltar";
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc]initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(salvaContato)];
    btnAdd.title = @"Adicionar";
    self.navigationItem.rightBarButtonItem = btnAdd;
}

- (void)viewDidUnload
{
    [self setNome:nil];
    [self setEmail:nil];
    [self setTelefone:nil];
    [self setEndereco:nil];
    [self setSite:nil];
    [self setFoto:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) cancelaForm{
    [self dismissModalViewControllerAnimated:YES];
}
-(void) salvaContato{
    Contato *contato = [[Contato alloc]init];
    [contato setNome:nome.text];
    [contato setEmail:email.text];
    [contato setEndereco:endereco.text];
    [contato setTelefone:telefone.text];
    [contato setSite:site.text];
    
    [delegate salvaContato:contato];
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)selecionaFoto:(id)sender{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca",nil];
        [sheet showInView:self.view];
    }else {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES]; 
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;            
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;            
            break;    
        default:
            return;            
    }
    
    [self presentModalViewController:picker animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagem = [info valueForKey:UIImagePickerControllerEditedImage];
    [foto setImage:imagem forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

@end
