//
//  AcessoBioViewController.m
//  AcessoBioReactNative
//
//  Created by Matheus Domingos on 13/07/21.
//

#import "UnicoCheckViewController.h"
#import "UnicoCheckModule.h"
#import <AcessoBio/AcessoBio-Swift.h>
#import "UnicoTheme.h"
#import "UnicoConfig.h"
#import "UnicoConfigLiveness.h"


@interface UnicoCheckViewController ()

@property (nonatomic, strong) NSString *jsonFileName;

@end

@implementation UnicoCheckViewController

documentType = DocumentRGFrente;

- (void)viewDidLoad {
  [super viewDidLoad];

  self.jsonFileName = @"";
  /*
   Para gerar o arquivo JSON é necessário criar uma API key. Siga os passos abaixo:
    - Acesse o portal do cliente da unico com suas credenciais;
    - Navegue em Configurações > Integração > API Key;
    - Crie ou edite uma nova API Key;
    - Marque o campo "Utiliza liveness ativo" como SIM caso queira habilitar a câmera Prova de Vidas ou NÃO caso queira utilizar a Câmera Normal ou Inteligente;
    - Marque o campo "Utiliza autenticação segura na SDK" como SIM;
    - Expanda a seção SDK iOS, adicione o nome de sua aplicação iOS e o Bundle ID;
    - Salve as alterações.
    - Neste momento, retornará para a página de API Key e ao lado da API Key desejada, pressione o botão de download do Bundle;
    - Selecione a opção iOS;
    - Clique em "Gerar";
    Atenção: Uma nova aba será aberta contendo informações do projeto em formato JSON.
    Caso a nova aba não abra, por favor, verifique se o seu navegador está bloqueando os popups.
    - Salve o conteúdo desta nova aba em um novo arquivo JSON;
    - Adicione o arquivo salvo no seu projeto e adicione abaixo o nome do arquivo json no "jsonConfigName"
  */

  unicoCheck = [[AcessoBioManager alloc] initWithViewController:self];
  // [unicoCheck setTheme:[[UnicoTheme alloc] init]];

  switch (_mode) {
    case DEFAULT:
      [self performSelector:@selector(callDefaultCamera) withObject:nil afterDelay:0.5];
      break;
    case SMART:
      [self performSelector:@selector(callSmartCamera) withObject:nil afterDelay:0.5];
      break;
    case LIVENESS:
      [self performSelector:@selector(callLivenessCamera) withObject:nil afterDelay:0.5];
      break;
    case DOCUMENT_RG_FRONT:
      [self performSelector:@selector(callDocumentRGFrontCamera)    withObject:nil afterDelay:0.5];
      break;
    case DOCUMENT_RG_BACK:
      [self performSelector:@selector(callDocumentRGBackCamera) withObject:nil afterDelay:0.5];
      break;
    case DOCUMENT_CNH:
      [self performSelector:@selector(callDocumentCNHCamera) withObject:nil afterDelay:0.5];
      break;
  }
}

- (void)callDefaultCamera {
  [unicoCheck setSmartFrame:false];
  [unicoCheck setAutoCapture:false];
  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareSelfieCamera:self config: [UnicoConfig new]];
}

- (void)callSmartCamera {
  [unicoCheck setSmartFrame:true];
  [unicoCheck setAutoCapture:true];
  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareSelfieCamera:self config: [UnicoConfig new]];
}

- (void)callLivenessCamera {
  NSLog(@"callLivenessCamera");
  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareSelfieCamera:self config: [UnicoConfigLiveness new]];
}

- (void)callDocumentRGFrontCamera {
  NSLog(@"callDocumentRGFrontCamera");
  documentType = DocumentRGFrente;
  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareDocumentCamera:self config: [UnicoConfig new]];
}

- (void)callDocumentRGBackCamera {
  NSLog(@"callDocumentRGBackCamera");
  documentType = DocumentRGVerso;
  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareDocumentCamera:self config: [UnicoConfig new]];
}

- (void)callDocumentCNHCamera {
  NSLog(@"callDocumentCNHCamera");
  documentType = DocumentCNH;
  [unicoCheck setTheme: [UnicoTheme new]];
  [[unicoCheck build] prepareDocumentCamera:self config: [UnicoConfig new]];
}

- (void)onErrorAcessoBioManager:(NSString *)error {
  [self.acessoBioModule onErrorAcessoBioManager:error];
  [self sair];
}

- (void)onCameraReady:(id)cameraOpener {
  [cameraOpener open:self];
}

-(void)onCameraReadyDocument:(id<AcessoBioCameraOpenerDelegate>)cameraOpener  {
  NSLog(@"onCameraReadyDocument");
  [cameraOpener openDocument:documentType delegate:self];
}

- (void)onCameraFailedDocument:(ErrorBio *)message{
  NSLog(@"onCameraFailedDocument");
  NSLog(@"%@", message.desc);
}

- (void)onCameraFailed:(ErrorBio *)message {
  NSLog(@"onCameraFailed");
  NSLog(@"%@", message.desc);
  [self sair];
}

- (void)onSuccessSelfie:(SelfieResult *)result {
// [self.acessoBioModule onSucessCamera:result.base64];
   [self.acessoBioModule onSucessCamera:result.encrypted];
//  [self.acessoBioModule onSucessCamera: @"Selfie capturada com sucesso"];
  [self sair];
}

- (void)onErrorSelfie:(ErrorBio *)errorBio {
  NSLog(@"onErrorSelfie");
  NSLog(@"%@", errorBio.desc);
  [self sair];
}

- (void)onSuccessDocument: (DocumentResult *)result {
//  [self.acessoBioModule onSucessCamera:result.base64];
    [self.acessoBioModule onSucessCamera:result.encrypted];
//  [self.acessoBioModule onSucessCamera: @"Documento capturado com sucesso"];
  [self sair];
}

- (void)onErrorDocument:(ErrorBio *)errorBio {
  NSLog(@"onErrorDocument");
  NSLog(@"%@", errorBio.desc);
}

- (void)onErrorCameraFace:(NSString *)error {
  NSLog(@"onErrorCameraFace");
  NSLog(@"%@", error);
  [self.acessoBioModule onErrorCameraFace:error];
  [self sair];
}

- (void)onSystemChangedTypeCameraTimeoutFaceInference {
  NSLog(@"onSystemChangedTypeCameraTimeoutFaceInference");
  [self.acessoBioModule systemClosedCameraTimeoutSession];
  [self sair];
}

- (void)onSystemClosedCameraTimeoutSession {
  NSLog(@"onSystemClosedCameraTimeoutSession");
  [self.acessoBioModule systemClosedCameraTimeoutSession];
  [self sair];
}

- (void)onUserClosedCameraManually {
  NSLog(@"onUserClosedCameraManually");
  [self.acessoBioModule userClosedCameraManually];
  [self sair];
}

- (void)sair{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [self dismissViewControllerAnimated:YES completion:nil];
  });
}

@end
