# Laya PDF Analyzer

Aplicação Rust/Axum para percorrer PDFs textuais em trechos sequenciais e executar uma árvore de análises, mostrando visualmente dependências e concorrência. A interface mantém o tema escuro do Laya Dataset Manager anterior.

## Iniciar

É necessário Rust estável e um compilador C/C++ para a dependência SQLite embarcada.

```bash
cp .env.example .env
cargo run
```

Abra `http://127.0.0.1:8082`. Há documento, bateria e provedor simulados determinísticos já carregados. Importe um PDF com camada de texto para substituir o documento de demonstração.

## LAYA real — estado atual

O repositório anterior demonstra uma rota local tipada `POST /v1/systemone`, mas não traz contrato verificável sobre tokenizer, orçamento total de contexto, formato completo de resposta, limites de concorrência ou cancelamento. Por isso este projeto **não chama esse endpoint**: ele usa um adaptador/provedor simulado, identificado claramente na tela.

Antes de ativar um provedor real, confirme esses itens na documentação/API instalada e implemente no adaptador:

- tokenizer oficial e cálculo de entrada + instrução + categorias + reserva de resposta;
- limite de contexto e validação antes de cada chamada;
- resposta estruturada com justificativa, evidência e metadados de token;
- política de timeout, tentativas, limitação e cancelamento.

O modo simulado usa contagem por palavras apenas para demonstração e emprega 650 ms por chamada para tornar o paralelismo visível; isso não é uma garantia de tokens LAYA.

## Limitações conhecidas

- Extração lê a camada textual do PDF; OCR e ordenação sofisticada de múltiplas colunas não estão incluídos.
- O esquema SQLite registra snapshots de execução; a retomada detalhada por resultado, importação/exportação JSON/CSV e o adaptador LAYA real são os próximos incrementos necessários para cobertura integral da especificação.
- Não armazene credenciais em SQLite, resultados ou exports.
