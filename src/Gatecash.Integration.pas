unit Gatecash.Integration;

interface

type
{$SCOPEDENUMS ON}
  TResponse = (COMMANDFAILURE, SUCCESS, COMMANDNOTINITIALIZED, INVALIDPARAMS);
{$SCOPEDENUMS OFF}

  TResponseHelper = record helper for TResponse
    /// <summary>
    /// Retorna o valor que representa o tipo selecionado do enum.
    /// </summary>
    function ToInteger: Integer;
    /// <summary>
    /// Converte o enum para uma string de fácil entendimento para o usuário.
    /// </summary>
    function ToString: string;
    /// <summary>
    /// Converte o enum para um Texto de fácil entendimento para o usuário.
    /// </summary>
    function ToText: string;
  end;

function IntToResponse(Value: Integer): TResponse;

/// Inicialização da comunicação com o GATECASH.
/// A aplicação deve inicializar a comunicação com o GATECASH antes que qualquer
/// evento de comunicação seja enviado. A inicialização da comunicação é
/// realizada apenas uma vez, quando o programa de frente de caixa é
/// inicializado.
/// Um arquivo de configuração (gcecho.config) é utilizado para carregar parâmetros.
/// Se não existir, um arquivo gcecho.config é gerado com valores padrão.
/// Para finalizar a comunicação com o GATECASH veja GATECASH_Finaliza().
/// @param CaminhoBase Caminho (path) básico onde GCPlug manipula arquivos auxiliares.
/// Normalmente é o caminho da aplicação. Usar "." para pasta local,
/// ou string vazia ("") para pasta do sistema operacional.
/// @param Servidor Sugestão de endereço IP do servidor GATECASH. Ex.: "127.0.0.1".
/// Essa informação é desconsiderada se o arquivo de configuração "gcecho.config"
/// tiver o parâmetro "Address". A configuração do arquivo é prioritária.
/// @param Pdv Sugestão de número do PDV que envia as mensagens.
/// Essa informação é desconsiderada se o arquivo de configuração "gcecho.config"
/// tiver o parâmetro "IdPdv". A configuração do arquivo é prioritária.
/// @remark Serão gravados registros de log em arquivos gcecho#.log, onde # indica
/// o dia da semana.
/// @return 0: Sucesso ao inicializar comunicação.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Finaliza.
function GATECASH_InicializaEx(const CaminhoBase: string; Servidor: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Inicialização da comunicação com o GATECASH.
/// A aplicação deve inicializar a comunicação com o GATECASH antes que qualquer
/// evento de comunicação seja enviado. A inicialização da comunicação é
/// realizada apenas uma vez, quando o programa de frente de caixa é
/// inicializado.
/// Um arquivo de configuração (gcecho.config) é utilizado para carregar parâmetros.
/// Se não existir, um arquivo gcecho.config é gerado com valores padrão.
/// Para finalizar a comunicação com o GATECASH veja GATECASH_Finaliza().
/// @param CaminhoBase Caminho (path) básico onde GCPlug manipula arquivos auxiliares.
/// Normalmente é o caminho da aplicação. Usar "." para pasta local,
/// ou string vazia ("") para pasta do sistema operacional.
/// @param Servidor Sugestão de endereço IP do servidor GATECASH. Ex.: "127.0.0.1".
/// Essa informação é desconsiderada se o arquivo de configuração "gcecho.config"
/// tiver o parâmetro "Address". A configuração do arquivo é prioritária.
/// @param Pdv Sugestão de número do PDV que envia as mensagens.
/// Essa informação é desconsiderada se o arquivo de configuração "gcecho.config"
/// tiver o parâmetro "IdPdv". A configuração do arquivo é prioritária.
/// @param CaminhoLog Caminho onde será salvo o arquivo de log. Se esse caminho for
/// String vazia ou NULL, o caminho utilizado será o CaminhoBase.
/// @remark Serão gravados registros de log em arquivos gcecho#.log, onde # indica
/// o dia da semana.
/// @return 0: Sucesso ao inicializar comunicação.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Finaliza.
function GATECASH_InicializaEx2(const CaminhoBase: string; const Servidor: string; Pdv: Integer; const CaminhoLog: string)
  : Integer; stdcall; external 'GCPlug.dll';

/// Finalização da comunicação com o GATECASH.
/// A finalização da comunicação é realizada apenas uma vez, quando o programa
/// de frente de caixa é encerrado. Esta função força o término de qualquer
/// conexão com outros módulos do GATECASH. Nenhum evento de comunicação será
/// enviado após a finalização. Para habilitar o envio de eventos de
/// comunicação, veja GATECASH_Inicializa().
/// @return 0: Sucesso finalizar comunicação.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Inicializa.
function GATECASH_Finaliza(): Integer; stdcall; external 'GCPlug.dll';

/// Evento de abertura do PDV.
/// A ser executado quando um operador inicia o acesso ao PDV (quando o PDV é aberto para vendas).
/// Também deve ser executado quando ocorrer troca o operador do PDV.
/// Geralmente associado ao login do operador no sistema de frente de caixa.
/// @param Funcionario Nome do funcionário que abriu o caixa.
/// Se não disponível, informar string vazia ("").
/// @param Codigo Codigo do funcionário que abriu o caixa.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_AbrePdvEx(const Funcionario: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Evento de fechamento do PDV.
/// A ser executado quando o operador finaliza o acesso ao PDV
/// (quando o PDV é fechado ou colocado em pausa). Este NÃO é o evento de
/// REDUÇÃO Z, e o caixa pode ser aberto novamente (ver GATECASH_AbrePdv).
/// Geralmente associado ao logout do operador do sistema de frente de caixa.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_AbrePdv.
function GATECASH_FechaPdv(): Integer; stdcall; external 'GCPlug.dll';

/// Informação de operador.
/// Adicionada em 201710 para manter mais consistente as informações de operador no sistema.
/// @param Funcionario Nome do funcionário que abriu o caixa.
/// @param Codigo Codigo do funcionário que abriu o caixa. Se não disponível, informar string vazia.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaOperador(const Funcionario: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de suprimento de caixa.
/// A ser executado quando o processo de suprimento de caixa é iniciado.
/// @param FormaPagamento String com nome da forma do suprimento de caixa.
/// @param Complemento Descrição complementar da operação realizada.
/// Se não utilizado, informar string vazia ("").
/// @param Valor Valor do suprimento (adicionado ao caixa).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Suprimento(const FormaPagamento: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de sangria do caixa.
/// A ser executado quando o processo de sangria do caixa é iniciado.
/// @param Complemento Descrição complementar da operação realizada.
/// Se não utilizado, informar string vazia ("").
/// @param Valor Valor da sangria (retirado do caixa).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Sangria(const Complemento: string; Valor: Double): Integer; stdcall; external 'GCPlug.dll';

/// Registro de operação genérica no PDV.
/// A ser executado quando forem realizadas operações genéricas no PDV não associadas
/// a um cupom. Por exemplo, operações não-fiscais, leitura x, redução z, etc.
/// @param Operacao Nome da operação realizada.
/// @param Complemento Descrição complementar da operação realizada.
/// Se não utilizado, informar string vazia ("").
/// @param Valor Valor associado à operação. Se não aplicável, utilizar zero.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Operacao(const Operacao: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Informa que gaveta foi aberta ou fechada.
/// A ser executado no instante em que a gaveta é acionada para abertura.
/// A execução deste comando é opcional quando for detectado o fechamento da gaveta.
/// @param Aberta Indica se é um evento de abertura da gaveta (1) ou fechamento da gaveta (0).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Gaveta(Aberta: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de cupom.
/// A ser executado quando o comando de abertura de cupom é registrado.
/// Cupom é finalizado pelo comando GATECASH_FechaDocumento().
/// @param Codigo Identificador numérico do cupom. Em geral, COO ou CNF.
/// Se não disponível, informar -1.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_FechaDocumento.
function GATECASH_AbreCupom(Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de documento genérico.
/// A ser executado quando for registrada a abertura de um documento (exceto cupom fiscal).
/// Alguns documentos genéricos são: cupom não fiscal, relatório gerencial, etc.
/// Um documento genérico é finalizado pelo comando GATECASH_FechaDocumento().
/// Em caso de documento instantâneo (sem duração variável), recomenda-se utilizar o comando
/// GATECASH_Operacao().
/// @param Nome String com nome do documento genérico aberto.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_Operacao()
/// @sa GATECASH_FechaDocumento.
function GATECASH_AbreDocumento(const Nome: string): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento.
/// A ser executado quando o cupom fiscal ou um documento genérico for finalizado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_AbreCupom, GATECASH_AbreDocumento.
function GATECASH_FechaDocumento(): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento.
/// A ser executado quando o cupom fiscal ou um documento genérico for finalizado.
/// @param Codigo - o código do documento que está sendo fechado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_AbreCupom, GATECASH_AbreDocumento.
function GATECASH_FechaDocumentoCod(Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de um cupom arbitrário.
/// A ser executado quando o cancelamento do cupom é efetivado.
/// @param Codigo Identificador numérico do cupom. Em geral, COO ou CNF.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelandoCupom.
function GATECASH_CancelaCupomEx(Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro da anulação de uma venda já fechada.
/// @param Pdv Identificador do PDV no qual foi realizada a venda anteriormente.
/// @param Codigo Identificador numérico do cupom. Em geral, COO ou CNF.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_AnulaCupom(Pdv: Integer; Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Associa informação de cliente ao cupom.
/// Deve ser executado enquanto o cupom está aberto e informa o cliente que realiza a compra.
/// Geralmente executado logo após a abertura do cupom ou pouco antes do seu fechamento.
/// @param Cliente String com nome do cliente ou string com número que o identifica (RG, CPF, etc).
/// @param Codigo String com o código do cliente.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaClienteEx(const Cliente: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Associa informação de Supervisor ao cupom (quem aprovou alguma operação que necessitava aprovação).
/// @param Supervisor é o identificador do supervisor que aprovou a operação.
/// @param Codigo é o código do supervisor que aprovou a operação.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaSupervisor(const Supervisor: string; const Codigo: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acréscimo ou desconto ao valor total do cupom.
/// A ser executado quando algum acréscimo ou desconto ao valor total do cupom é
/// impresso. Este registro normalmente é associado ao início do fechamento do
/// cupom, ou seja, depois do último item vendido e antes do registro da
/// primeira forma de pagamento. O registro de diferença no cupom não é
/// necessário caso não haja acréscimo ou desconto ao valor total do cupom.
/// A especificação de diferença do cupom NÃO é acumulativa.
/// Será considerada apenas a última chamada de GATECASH_DiferencaCupom() para cada cupom.
/// @param Diferenca Acréscimo (positivo) ou desconto (negativo) no valor total do cupom.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_DiferencaCupom(Diferenca: Double): Integer; stdcall; external 'GCPlug.dll';

/// Registro de venda de item diferenciação se é unitário e se foi digitado...
/// A ser executado quando a venda de item (com ou sem desconto) é registrada.
/// Se o item tiver acréscimo ou desconto, esta diferença de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo após o registro do item, informando o valor de acréscimo/desconto.
/// @param Sequencia Índice da seqüência do item vendido no cupom. É o mesmo índice que será
/// utilizado como referência para registro de diferença de item, cancelamento de item, etc.
/// @param Codigo String com código do produto vendido (código de barras).
/// @param Descricao String com descrição do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unitário do produto.
/// Valor da venda é calculado por Quantidade X ValorUnitário.
/// @param Unitario flag que indica se o item é unitário ou é um item que possui venda por peso.
/// @param Scaneado flag que indica se o item foi escaneado ou digitado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_VendeItemEx(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean): Integer; stdcall; external 'GCPlug.dll';

/// Registro de venda de item com diferenciação se é unitário e se foi digitado..
/// Esse registro de venda de item deve ser utilizado apenas para itens fora do padrão (como, por exemplo, itens que são
/// escaneados com scanner de mão. Itens registrados com scanners de mesa ou digitados devem ser registrados com os métodos
/// VendeItem e VendeItemEx.
/// Se o item tiver acréscimo ou desconto, esta diferença de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo após o registro do item, informando o valor de acréscimo/desconto.
/// @param Sequencia Índice da seqüência do item vendido no cupom. É o mesmo índice que será
/// utilizado como referência para registro de diferença de item, cancelamento de item, etc.
/// @param Codigo String com código do produto vendido (código de barras).
/// @param Descricao String com descrição do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unitário do produto.
/// Valor da venda é calculado por Quantidade X ValorUnitário.
/// @param Unitario flag que indica se o item é unitário ou é um item que possui venda por peso.
/// @param Scaneado flag que indica se o item foi escaneado ou digitado.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_VendeItemFp(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Consulta de preço de produto.
/// A ser executado quando for feita a consulta de preço de um produto,
/// independente de haver um cupom aberto ou não.
/// @param Codigo String com código do produto consultado.
/// @param Descricao String com descrição do produto consultado.
/// @param ValorUnitario Valor unitário do produto.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_ConsultaProduto(const Codigo: string; const Descricao: string; Valor: Double; Unitario: Boolean): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de item.
/// A ser executado quando o cancelamento de item é registrado (quando é efetivado).
/// @param Sequencia Índice do item que foi cancelado.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica último item vendido.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_CancelaItem(Sequencia: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acréscimo ou desconto a uma venda de item.
/// A ser executado ao registrar acréscimo ou desconto à venda de um item.
/// Em geral é executado imediatamente após GATECASH_VendeItem,
/// registrando a diferença lançada no item vendido. A diferença lançada por
/// GATECASH_DiferencaItem() NÃO é acumulativa. O registro de diferença no item não é
/// necessário caso não haja acréscimo ou desconto ao valor do item vendido.
/// @param Sequencia Índice do item referente ao acréscimo/desconto.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica o último item vendido.
/// @param Diferenca Valor absoludo de acréscimo (positivo) ou desconto (negativo)
/// no valor da venda do item.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_VendeItem.
function GATECASH_DiferencaItem(Sequencia: Integer; Diferenca: Double): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acréscimo ou desconto a uma venda de item.
/// A ser executado ao registrar acréscimo ou desconto à venda de um item.
/// Em geral é executado imediatamente após GATECASH_VendeItem,
/// registrando a diferença lançada no item vendido. A diferença lançada por
/// GATECASH_DiferencaItem() NÃO é acumulativa. O registro de diferença no item não é
/// necessário caso não haja acréscimo ou desconto ao valor do item vendido.
/// @param Sequencia Índice do item referente ao acréscimo/desconto.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica o último item vendido.
/// @param Diferenca Valor absoludo de acréscimo (positivo) ou desconto (negativo)
/// no valor da venda do item.
/// @param Motivo é a razão do desconto.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_VendeItem.
function GATECASH_DiferencaItemEx(Sequencia: Integer; Diferenca: Double; const Motivo: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Informa desmagnetização de etiqueta magnética durante um cupom ou documento.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_Desmagnetizacao(): Integer; stdcall; external 'GCPlug.dll';

/// Registro de forma de pagamento.
/// A ser executado quando uma forma de pagamento for registrada.
/// @param FormaPagamento String com nome da forma de pagamento.
/// @param Valor Valor pago através da forma de pagamento.
/// @param Complemento Informação adicional associada ao pagamento. Ex.: Número do cartão.
/// Se não disponível, informar string vazia ("").
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_FormaPagamento(const FormaPagamento: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Cancelamento de registro de forma de pagamento.
/// A ser executado quando for registrado o estorno de uma forma de pagamento.
/// Em geral, o valor estornado de uma forma de pagamento é movido para ser registrado em outra
/// forma de pagamento. Neste caso, um cancelamento de pagamento deve ser seguido de um novo
/// comando de forma de pagamento GATECASH_FormaPamento() com o mesmo valor estornado.
/// @param FormaPagamento String com nome da forma de pagamento cancelada.
/// @param Valor Valor cancelado da forma de pagamento.
/// Não negativar o valor cancelado. Ex.: se estornado R$10, informar 10.
/// @param Complemento Informação adicional associada ao cancelamento.
/// Se não disponível, informar string vazia ("").
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_CancelaPagamento(const FormaPagamento: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Informacao de erro genérico do sistema.
/// Informações como o	Erro de comunicação com impressora, fim de papel, enfim, qualquer erro.
/// @param CodigoErro string que define o código do erro
/// @param NomeErro string que define o nome do erro
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando
function GATECASH_ErroGenerico(const CodigoErro: string; const NomeErro: string): Integer; stdcall; external 'GCPlug.dll';

/// Informacao de Alerta genérico do sistema
/// Alertas como pouco papel em impressora, inatividade, etc podem ser registrados por esse alerta.
/// @param CodigoAlerta string que define o código do Alerta
/// @param NomeAlerta string que define o nome do Alerta
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando
function GATECASH_AlertaGenerico(const CodigoAlerta: string; const NomeAlerta: string): Integer; stdcall; external 'GCPlug.dll';

/// Informacao de Ocorrência genérica.
/// Ocorrências como pedido de ajuda de cliente, Terminal inativo, etc podem ser registrados por esta mensagem.
/// @param CodigoOcorrencia string que define o código da Ocorrencia
/// @param NomeOcorrencia string que define o nome da Ocorrencia
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando
function GATECASH_OcorrenciaGenerico(const CodigoOcorrencia: string; const NomeOcorrencia: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de abertura de transferência de mercadoria
/// Deve ser executada quando uma operação de transferência de mercadoria tem início
/// Uma abertura de transferência é finalizada pelo comando GATECASH_FechaTransferência().
/// @param Identificador String identificando o processo de transferência
/// @param NomeLocal String identificando o local da transferência
/// @param DataEmissao Data de emissão da nota fiscal ou pedido
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_SuspendeTransferencia
/// @sa GATECASH_FechaTransferencia
function GATECASH_AbreTransferencia(const Identificador: string; const NomeLocal: string; DataEmissao: TDate): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de nota fiscal.
/// Alguns casos de sistema de recebimento podem ter mais de uma nota fiscal vinculada, por isso a criação dessa função.
/// @param Identificador String identificando o processo de transferência
/// @param Serie String identificando Série no processo de transferência
/// @param DataEmissao data emissão da nota
/// @param Entrada booleano que indica se é entrada (true) ou saída (false)
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_AbreTransferencia
function GATECASH_InformaNF(const Identificador: string; const Serie: string; DataEmissao: TDate; Entrada: Boolean): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro de suspensão de transferência de mercadoria
/// Deve ser executada quando uma operação de transferência de mercadoria é interrompida por algum motivo
/// Uma transferência pode ser retomada pelo comando GATECASH_RetomaTransferencia().
/// @param Identificador String identificando o processo de transferência
/// @param Motivo String identificando o motivo da suspensão da transferência
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_RetomaTransferencia
function GATECASH_SuspendeTransferencia(const Identificador: string; const Motivo: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de retomada de transferência de mercadoria
/// Deve ser executada quando uma operação de transferência de mercadoria estava interrompida e foi retomada
/// Uma transferência pode ser suspendida pelo comando GATECASH_SuspendeTransferencia().
/// @param Identificador String identificando o processo de transferência
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_SuspendeTransferencia
function GATECASH_RetomaTransferencia(const Identificador: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de cancelamento de transferência de mercadoria
/// Deve ser executada quando uma operação de transferência de mercadoria é cancelada antes de ser concluída
/// Impossibilita qualquer ação posterior vinculada a essa transferência
/// @param Identificador String identificando o processo de transferência
/// @param Motivo String identificando o motivo do cancelamento da transferência
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_AbreTransferencia
/// @sa GATECASH_FechaTransferencia
function GATECASH_CancelaTransferencia(const Identificador: string; const Motivo: string): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de fechamento de transferência de mercadoria
/// Deve ser executada quando uma operação de transferência de mercadoria é concluída com sucesso
/// Impossibilita qualquer ação posterior vinculada a essa transferência
/// @param Identificador String identificando o processo de transferência
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_AbreTransferencia
/// @sa GATECASH_CancelaTransferencia
function GATECASH_FechaTransferencia(const Identificador: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro do tipo de transferência que está sendo realizada
/// Deve ser executada após a abertura de uma transferência
/// É vinculada à transferência atualmente ativa
/// @param Tipo inteiro que informa a natureza da transferência: 1 - Recebimento; 2 - Devolução; 3 - Saída; 4 - Outros
/// @param Descricao usado para informar o nome caso seja a transferência seja do tipo outros
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaConferente
/// @sa GATECASH_InformaFornecedor
function GATECASH_InformaTipoTransferencia(Tipo: Integer; const Descricao: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro do funcionário que está conferindo a transferência
/// Deve ser executada após a abertura de uma transferência
/// É vinculada à transferência atualmente ativa
/// @param Identificador Código do conferente que está realizando a transferência
/// @param Nome Nome do conferente que está realizando a transferência
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaTipoTransferencia
/// @sa GATECASH_InformaFornecedor
function GATECASH_InformaConferente(const Identificador: string; const Nome: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro do fornecedor da transferência
/// Deve ser executada após a abertura de uma transferência
/// É vinculada à transferência atualmente ativa
/// @param Identificador Código do fornecedor atribuído à transferência
/// @param Nome Nome do fornecedor atribuído à transferência
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaTipoTransferencia
/// @sa GATECASH_InformaConferente
function GATECASH_InformaFornecedor(const Identificador: string; const Nome: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de saída de veículo
/// Deve ser executado apenas em uma transferência do tipo saída
/// @param Placa Placa associada ao veículo de transporte
/// @param TipoVeiculo Nome associado ao veículo de transporte
/// @param CodigoMotorista Identificador que pode ser CPF, RG ou CNH
/// @param NomeMotorista Nome do Condutor
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_InformaFornecedor
/// @sa GATECASH_InformaTipoTransferencia
function GATECASH_InformaSaidaVeiculo(const Placa: string; const TipoVeiculo: string;
  const CodigoMotorista: string; const NomeMotorista: string): Integer; stdcall; external 'GCPlug.dll';

/// Sinaliza o início de uma contagem ou recontagem
/// Deve ser executada após a abertura de uma transferência e antes de iniciar a transferência de itens
/// É vinculada à transferência atualmente ativa
/// @param Tipo Usado para identificar se os itens que serão transferidos pertencem a uma contagem (1) ou recontagem (2)
/// @return 0: Sucesso ao enviar evento
/// @return -1: Comunicação não inicializada
/// @return -999: Falha ao executar comando
/// @sa GATECASH_InformaTipoTransferencia
/// @sa GATECASH_InformaConferente
function GATECASH_RegistraContagem(Tipo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de transferência de item.
/// Deve ser executada após um registro de contagem e antes do fechamento de transferência de itens
/// @param Sequencia Índice da sequência do item transferido. É o mesmo índice que será
/// utilizado como referência para cancelamento de item
/// @param Codigo String com código do produto transferido (normalmente código de barras).
/// @param Descricao String com descrição do produto transferido.
/// @param NomeTipoEmbalagem String com nome associado ao tipo de embalagem, i.e. pallet, caixa, fardo, ...
/// @param QuantidadeEmbalagem Quantidade de embalagem na transferência
/// @param QuantidadeItem Quantidade total de itens na transferência
/// @param Validade Validade do lote de itens transferidos
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_RegistraContagem
/// @sa GATECASH_CancelaItemTransferencia
function GATECASH_TransfereItem(Sequencia: Integer; const Codigo: string; const Descricao: string;
  const Nome: string; TipoEmbalagem, QuantidadeEmbalagem: Integer;
  QuantidadeItem: Double; Validade: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de cancelamento de um item da transferência.
/// Deve ser executada após um registro de contagem e antes do fechamento de transferência de itens
/// @param Sequencia Índice da sequência do item transferido a ser cancelado
/// @param QuantidadeItem Quantidade de itens que foram cancelados
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_RegistraContagem
/// @sa GATECASH_TransfereItem
function GATECASH_CancelaItemTransferencia(Sequencia: Integer; QuantidadeItem: Double): Integer; stdcall; external 'GCPlug.dll';

//* *********** METHODS THAT INFORM MULTIPLES PDVS IN ONE INSTANCE OF GATECASH ******* *//
//* ******************** OPERATION EQUALS THE ABOVE FUNCTIONS **************** ******* *//
/// Evento de abertura de um determinado pdv.
function GATECASH_AbrePdvEx_InformPDV(const Funcionario: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Evento de fechamento de um determinado PDV.
function GATECASH_FechaPdv_InformPDV(Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Informação de operador de um determinado pdv.
function GATECASH_InformaOperador_InformPDV(const Funcionario: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de suprimento de caixa de um determinado pdv.
function GATECASH_Suprimento_InformPDV(const FormaPagamento: string; const Complemento: string; Valor: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Registro de sangria do caixa de um determinado pdv.
function GATECASH_Sangria_InformPDV(const Complemento: string; Valor: Double; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de operação genérica de um determinado pdv.
function GATECASH_Operacao_InformPDV(const Operacao: string; const Complemento: string; Valor: Double; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Informa que gaveta foi aberta ou fechada de um determinado pdv.
function GATECASH_Gaveta_InformPDV(Aberta: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de cupom de um determinado pdv.
function GATECASH_AbreCupom_InformPDV(Codigo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de documento genérico de um determinado pdv.
function GATECASH_AbreDocumento_InformPDV(const Nome: string; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento de um determinado pdv.
function GATECASH_FechaDocumento_InformPDV(Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Fechamento de cupom ou documento de um determinado pdv.
function GATECASH_FechaDocumentoCod_InformPDV(Codigo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de um cupom arbitrário de um determinado pdv.
function GATECASH_CancelaCupomEx_InformPDV(Codigo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro da anulação de uma venda já fechada de um determinado pdv.
function GATECASH_AnulaCupom_InformPDV(Pdv: Integer; Codigo: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Associa informação de cliente ao cupom de um determinado pdv.
function GATECASH_InformaClienteEx_InformPDV(const Cliente: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Associa informação de Supervisor ao cupom (quem aprovou alguma operação que necessitava aprovação) de um determinado pdv.
function GATECASH_InformaSupervisor_InformPDV(const Supervisor: string; const Codigo: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de acréscimo ou desconto ao valor total do cupom de um determinado pdv.
function GATECASH_DiferencaCupom_InformPDV(Diferenca: Double; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de venda de item diferenciação se é unitário e se foi digitado...de um determinado pdv
function GATECASH_VendeItemEx_InformPDV(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de venda de item com diferenciação se é unitário e se foi digitado.. de um determinado pdv
function GATECASH_VendeItemFp_InformPDV(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Unitario: Boolean; Escaneado: Boolean; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Consulta de preço de produto de um determinado pdv.
function GATECASH_ConsultaProduto_InformPDV(const Codigo: string; const Descricao: string; ValorUnitario: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento de item de um determinado pdv.
function GATECASH_CancelaItem_InformPDV(Sequencia: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de acréscimo ou desconto a uma venda de item de um determinado pdv.
function GATECASH_DiferencaItem_InformPDV(Sequencia: Integer; Diferenca: Double; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de acréscimo ou desconto a uma venda de item de um determinado pdv.
function GATECASH_DiferencaItemEx_InformPDV(Sequencia: Integer; Diferenca: Double; const Motivo: string; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Informa desmagnetização de etiqueta magnética durante um cupom ou documento de um determinado pdv.
function GATECASH_Desmagnetizacao_InformPDV(Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de forma de pagamento de um determinado pdv.
function GATECASH_FormaPagamento_InformPDV(const FormaPagamento: string; const Complemento: string; Valor: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Cancelamento de registro de forma de pagamento de um determinado pdv.
function GATECASH_CancelaPagamento_InformPDV(const FormaPagamento: string; const Complemento: string; Valor: Double; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Informacao de erro genérico do sistema de um determinado pdv.
function GATECASH_ErroGenerico_InformPDV(const CodigoErro: string; const NomeErro: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Informacao de Alerta genérico do sistema de um determinado pdv
function GATECASH_AlertaGenerico_InformPDV(const CodigoAlerta: string; const NomeAlerta: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Informacao de Ocorrência genérica de um determinado pdv.
function GATECASH_OcorrenciaGenerico_InformPDV(const CodigoOcorrencia: string; const NomeOcorrencia: string; Pdv: Integer)
  : Integer; stdcall; external 'GCPlug.dll';

/// Registro de abertura de transferência de mercadoria de um determinado pdv
function GATECASH_AbreTransferencia_InformPDV(const Identificador: string; const NomeLocal: string; DataEmissao: TDate;
  Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de suspensão de transferência de mercadoria de um determinado pdv
function GATECASH_SuspendeTransferencia_InformPDV(const Identificador: string; const Motivo: string; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro de retomada de transferência de mercadoria de um determinado pdv
function GATECASH_RetomaTransferencia_InformPDV(const Identificador: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de cancelamento de transferência de mercadoria de um determinado pdv
function GATECASH_CancelaTransferencia_InformPDV(const Identificador: string; const Motivo: string; Pdv: Integer): Integer;
  stdcall; external 'GCPlug.dll';

/// Registro de fechamento de transferência de mercadoria de um determinado pdv
function GATECASH_FechaTransferencia_InformPDV(const Identificador: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro do tipo de transferência que está sendo realizada de um determinado pdv
function GATECASH_InformaTipoTransferencia_InformPDV(Tipo: Integer; const Descricao: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro do funcionário que está conferindo a transferência de um determinado pdv
function GATECASH_InformaConferente_InformPDV(const Identificador: string; const Nome: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro do fornecedor da transferência de um determinado pdv
function GATECASH_InformaFornecedor_InformPDV(const Identificador: string; const Nome: string; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de saída de veículo de um determinado pdv
function GATECASH_InformaSaidaVeiculo_InformPDV(const Placa: string; const TipoVeiculo: string;
  const CodigoMotorista: string; const NomeMotorista: string; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Sinaliza o início de uma contagem ou recontagem de um determinado pdv
function GATECASH_RegistraContagem_InformPDV(Tipo: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de transferência de item de um determinado pdv.
function GATECASH_TransfereItem_InformPDV(Sequencia: Integer; const Codigo: string; const Descricao: string;
  const NomeTipoEmbalagem: string; QuantidadeEmbalagem: Integer;
  QuantidadeItem: Double; Validade: Integer; Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Registro de cancelamento de um item da transferência de um determinado pdv.
function GATECASH_CancelaItemTransferencia_InformPDV(Sequencia: Integer; QuantidadeItem: Double; Pdv: Integer): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de informação de nota fiscal.
function GATECASH_InformaNF_InformPDV(const Identificador: string; const Serie: string; DataEmissao: TDate; Entrada: Boolean;
  Pdv: Integer): Integer; stdcall; external 'GCPlug.dll';

//* ****************************** DEPRECATED METHODS ******************************** *//

/// Inicialização da comunicação com o GATECASH (simplificado).
/// Equivale a executar GATECASH_InicializaEx() sem informar Servidor e Pdv.
/// Veja documentação de GATECASH_InicializaEx() para mais informações.
/// @param CaminhoBase Caminho (path) básico onde GCPlug manipula arquivos auxiliares.
/// @return 0: Sucesso ao inicializar comunicação.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_InicializaEx.
/// @sa GATECASH_Finaliza.
/// @remark Servidor e Pdv devem estar especificados no arquivo de configuração.
function GATECASH_Inicializa(const CaminhoBase: string): Integer; stdcall; external 'GCPlug.dll';

/// Evento de abertura do PDV.
/// A ser executado quando um operador inicia o acesso ao PDV (quando o PDV é aberto para vendas).
/// Também deve ser executado quando ocorrer troca o operador do PDV.
/// Geralmente associado ao login do operador no sistema de frente de caixa.
/// @param Funcionario Nome do funcionário que abriu o caixa.
/// Se não disponível, informar string vazia ("").
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_AbrePdv(const Funcionario: string): Integer; stdcall; external 'GCPlug.dll';

/// Associa informação de cliente ao cupom.
/// Deve ser executado enquanto o cupom está aberto e informa o cliente que realiza a compra.
/// Geralmente executado logo após a abertura do cupom ou pouco antes do seu fechamento.
/// @param Cliente String com nome do cliente ou string com número que o identifica (RG, CPF, etc).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaCliente(const Cliente: string): Integer; stdcall; external 'GCPlug.dll';

/// Início do cancelamento do último cupom.
/// A ser executado quando o processo de cancelamento de cupom é iniciado.
/// Em geral, quando o operador de caixa solicita a presença do supervisor para cancelar o cupom.
/// O cancelamento refere-se ao último cupom registrado, que pode já ter sido concluído ou não.
/// Este comando é opcional, pois em muitos sistemas de frente de caixa o "início de cancelamento"
/// não passa pelo sistema.
/// Independente de executar GATECASH_CancelandoCupom(), o comando GATECASH_CancelaCupom()
/// deverá ser executado quando o cancelamento do cupom for efetivado (enviado à impressora).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelaCupom.
function GATECASH_CancelandoCupom(): Integer; stdcall; external 'GCPlug.dll';

/// Registro do cancelamento do último cupom.
/// A ser executado quando o cancelamento do cupom é registrado (quando é efetivado).
/// O cancelamento refere-se ao último cupom registrado, que pode já ter sido concluído ou não.
/// Caso o cancelamento tenha sido iniciado (ver GATECASH_CancelandoCupom()) e não efetivado,
/// basta não executar este comando.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelandoCupom.
function GATECASH_CancelaCupom(): Integer; stdcall; external 'GCPlug.dll';

/// Adiciona detalhe a um cupom ou documento genérico.
/// Deve ser executado enquando houver um cupom ou documento genérico aberto.
/// A execução deste comando depende da regra de negócio da aplicação.
/// Detalhes são listados ao visualizar um cupom ou documento genérico, mas não são computados
/// como vendas e não são totalizados no cupom ou documento genérico.
/// @param Nome String com nome do tipo de detalhe adicionado.
/// @param Complemento Descrição complementar do detalhe adicionado.
/// Se não utilizado, informar string vazia ("").
/// @param Valor Valor associado ao detalhe. Se não aplicável, informar 0.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_InformaDetalhe(const Nome: string; const Complemento: string; Valor: Double): Integer; stdcall;
  external 'GCPlug.dll';

/// Registro de venda de item.
/// A ser executado quando a venda de item (com ou sem desconto) é registrada.
/// Se o item tiver acréscimo ou desconto, esta diferença de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo após o registro do item, informando o valor de acréscimo/desconto.
/// @param Sequencia Índice da seqüência do item vendido no cupom. É o mesmo índice que será
/// utilizado como referência para registro de diferença de item, cancelamento de item, etc.
/// @param Codigo String com código do produto vendido (código de barras).
/// @param Descricao String com descrição do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unitário do produto.
/// Valor da venda é calculado por Quantidade X ValorUnitário.
/// @param Indice Número adicional associado à venda do item. A ser definido
/// pela regra de negócio. Se não disponível, informar -1.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_VendeItem(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Quantidade: Double; ValorUnitario: Double; Indice: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Início do cancelamento de item.
/// A ser executado quando o processo de cancelamento de item é iniciado.
/// Em geral, quando o operador de caixa solicita a presença do supervisor para cancelar o item.
/// Este comando é opcional, pois em muitos sistemas de frente de caixa o "início de cancelamento"
/// não passa pelo sistema.
/// Independente de executar GATECASH_CancelandoItem(), o comando GATECASH_CancelaItem()
/// deverá ser executado quando o cancelamento do item for efetivado (enviado à impressora).
/// @param Sequencia Índice do item a ser cancelado.
/// Ex.: 1 indica o primeiro item do cupom. Se -1, indica último item vendido.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_CancelaItem.
function GATECASH_CancelandoItem(Sequencia: Integer): Integer; stdcall; external 'GCPlug.dll';

//* ****************************** UNDOCUMENTED METHODS ******************************** *//

/// Envia mensagem de evento com protocolo público.
/// @param Mensagem String que retornará com mensagem montada.
/// @param Tamanho Tamanho da string de retorno (em bytes).
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
function GATECASH_EventoPublico(const Mensagem: string; Tamanho: Integer): Integer; stdcall; external 'GCPlug.dll';

/// Monta mensagem de evento com protocolo público.
/// A execução deste comando não depende da inicialização da comunicação.
/// Este comando expoe os principais campos disponíveis no protocolo público,
/// mas apenas alguns campos são utilizados em cada tipo de evento.
/// Utilize valor ZERO ou strings NULAS como valores default dos campos.
/// @param Mensagem String que retornará com mensagem montada.
/// @param Tamanho Tamanho da string de retorno (em bytes). Normalmente 140.
/// @param Pdv Identificador do PDV.
/// @param Evento Código indicando o tipo do evento.
/// @param Codigo Código do produto, forma de pagamento, funcionário, etc.
/// @param Descricao Descrição/nome do produto, pagamento, funcionário, etc.
/// @param Unidade Unidade (2 caracteres) do produto vendido.
/// @param Quantidade Quantidade vendida.
/// @param ValorUnitario Valor unitário do produto vendido.
/// @param Valor Valor total do iten vendido.
/// @param Indice Índice extra associado ao evento.
/// @param Obs Observações adicionais associadas ao evento.
/// @return 0: Sucesso ao montar mensagem.
/// @return -2: Parâmetros inválidos. Não foi possível montar a mensagem.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_EventoPublico().
function GATECASH_MontaEventoPublico(Mensagem: string; Tamanho: Integer;
  Pdv: Integer; Evento: Integer;
  const Codigo: string; const Descricao: string;
  const Unidade: string; Quantidade: Float32;
  ValorUnitario: Float32; Valor: Float32;
  Indice: Integer; const Obs: string): Integer; stdcall; external 'GCPlug.dll';

/// Registro de recebimento de item.
/// A ser executado quando uma troca ou devolução de produto é realizada.Utilizada também em recebimento de mercadorias;
///  ---------------  Atributos abaixo devem ser analisados: ----------------------------
/// Se o item tiver acréscimo ou desconto, esta diferença de valor deve ser informada chamando
/// GATECASH_DiferencaItem() logo após o registro do item, informando o valor de acréscimo/desconto.
/// @param Sequencia Índice da seqüência do item vendido no cupom. É o mesmo índice que será
/// utilizado como referência para registro de diferença de item, cancelamento de item, etc.
/// @param Codigo String com código do produto vendido (código de barras).
/// @param Descricao String com descrição do produto vendido.
/// @param Quantidade Quantidade da venda do produto.
/// @param ValorUnitario Valor unitário do produto.
/// Valor da venda é calculado por Quantidade X ValorUnitário.
/// @param Indice Número adicional associado à venda do item. A ser definido
/// pela regra de negócio. Se não disponível, informar -1.
/// @return 0: Sucesso ao enviar evento.
/// @return -1: Comunicação não inicializada.
/// @return -999: Falha ao executar comando.
/// @sa GATECASH_DiferencaItem.
function GATECASH_RecebeItem(Sequencia: Integer; const Codigo: string; const Descricao: string;
  Qunantidade: Double; ValorUnitario: Double; Indice: Integer): Integer; stdcall; external 'GCPlug.dll';

implementation

{ TResponseHelper }

function IntToResponse(Value: Integer): TResponse;
begin
  case Value of
    0:
      Result := TResponse.SUCCESS;
    -1:
      Result := TResponse.COMMANDNOTINITIALIZED;
    -2:
      Result := TResponse.INVALIDPARAMS
    else
      Result := TResponse.COMMANDFAILURE;
  end;
end;

function TResponseHelper.ToInteger: Integer;
begin
  case Self of
    TResponse.SUCCESS:
      Result := 0;
    TResponse.COMMANDNOTINITIALIZED:
      Result := -1;
    TResponse.INVALIDPARAMS:
      Result := -2
    else
      Result := -999;
  end;
end;

function TResponseHelper.ToString: string;
begin
  case Self of
    TResponse.SUCCESS:
      Result := '0';
    TResponse.COMMANDNOTINITIALIZED:
      Result := '-1';
    TResponse.INVALIDPARAMS:
      Result := '-2'
    else
      Result := '-999';
  end;
end;

function TResponseHelper.ToText: string;
begin
  case Self of
    TResponse.SUCCESS:
      Result := 'Comunicação realizada com sucesso.';
    TResponse.COMMANDNOTINITIALIZED:
      Result := 'Comunicação não inicializada';
    TResponse.INVALIDPARAMS:
      Result := 'Parâmetros inválidos. Não foi possível montar a mensagem.';
    else
       Result := 'Falha ao executar comando.';
  end;
end;

end.
