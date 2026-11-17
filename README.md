# Tema Pedaco Cloud para Apache Guacamole

Tema para o Apache Guacamole com uma paleta suave em tons de vermelho. Personaliza
a tela de login, o cabeçalho e a página inicial, onde as conexões são apresentadas
em cards numa grelha e os grupos como cabeçalhos expansíveis. Usa os ícones já
fornecidos na pasta `images/` e define o nome da aplicação como "Pedaco Cloud".

## Gerar a extensão

É necessário ter Python 3. Na raiz deste projeto, execute:

```sh
./build-theme.sh
```

O arquivo `dist/pedaco-guacamole-theme.jar` será criado com o manifesto, o CSS,
as traduções e os ícones nas posições esperadas pelo Guacamole.

## Instalar

Copie o `.jar` para a pasta `extensions` dentro do `GUACAMOLE_HOME` (por padrão,
`/etc/guacamole/extensions`) e reinicie o serviço/contêiner do Guacamole. Depois,
atualize a página no navegador limpando o cache (Ctrl+F5).

### Instalar em Docker

Com Docker e Python 3 disponíveis, execute:

```sh
./load-theme-docker.sh <nome-ou-id-do-container-guacamole>
```

O script gera a extensão, copia-a para `GUACAMOLE_HOME/extensions` no contêiner
em execução e reinicia esse contêiner, interrompendo temporariamente as conexões.
É necessário ter acesso ao daemon Docker e permissão de escrita no diretório de
extensões. Se `GUACAMOLE_HOME` não estiver definido, usa `/etc/guacamole`.

Para manter o tema ao recriar o contêiner, monte o diretório de extensões num
volume persistente e gravável. Sem esse volume, será necessário executar o script
novamente após a recriação.

O manifesto usa `"guacamoleVersion": "*"` porque esta extensão fornece apenas
CSS, traduções e ícones e não depende de APIs internas do Guacamole. Para desfazer
a personalização, remova o `.jar` da pasta `extensions` e reinicie o Guacamole.
