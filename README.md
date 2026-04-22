# 📦 GetX no Flutter

## 📌 O que é o GetX?

O **GetX** é uma biblioteca para Flutter que combina:

- Gerenciamento de estado de alta performance
- Injeção de dependência inteligente
- Gerenciamento de rotas

Tudo isso de forma **rápida, simples e prática**.

---

## 🚀 Princípios básicos

### ⚡ Performance
Focado em alto desempenho e baixo consumo de recursos.

### 🚀 Produtividade
Sintaxe simples, direta e fácil de usar.

### 🧩 Organização
Permite o desacoplamento entre:

- View (interface)
- Lógica de apresentação
- Lógica de negócio
- Injeção de dependência
- Navegação

---

## 📥 Instalação

```bash
flutter pub add get

````
## 📌 Uso do GetX no Projeto

O **GetX** foi utilizado no arquivo `livro_list.dart` para gerenciar o estado da aplicação e simplificar a navegação.

### ✔️ Aplicações no arquivo:

- Uso de `GetxController` para centralizar a lógica
- Lista reativa com `.obs`
- Atualização automática da interface com `Obx`
- Navegação utilizando `Get.to()`
- Exibição de mensagens com `Get.snackbar`
- Diálogos com `Get.defaultDialog`

Essa abordagem elimina a necessidade de `setState`, tornando o código mais organizado, reativo e fácil de manter.
