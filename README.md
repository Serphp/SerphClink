# ⚡ SerphClink - Cyberpunk 2077 Terminal Suite

Suite completa de personalización, automatización y productividad para la terminal de Windows (**PowerShell**, **CMD** y **MSYS2**) inspirada en la interfaz **HUD de Cyberpunk 2077**.

---

## 📦 ¿Qué incluye?

* **Starship Prompt:** Tema temático *Cyberpunk 2077 HUD* (Yellow `#FCEE0A`, Trauma Team Red `#FF003C`, Kiroshi Cyan `#00F0FF`, advertencia `RELIC MALFUNCTION` en errores).
* **Fastfetch:** Información y métricas gráficas del sistema que se muestran automáticamente al abrir cualquier terminal.
* **Clink (para CMD):** Autocompletado inteligente estilo Fish, historial persistente y puente directo para que CMD tenga el mismo prompt de Starship.
* **MSYS2 (UCRT64):** Entorno Unix/Linux nativo de alto rendimiento con gestor `pacman` y perfil integrado en Windows Terminal (`/home/kali`).
* **Serph Toolkit (Atajos y Macros):** Más de 80 atajos para Git, desarrollo web (NPM/Bun/PNPM), Prisma, Flutter, Python, Docker, redes, ciberseguridad y utilidades de sistema.
* **Antigravity CLI:** Atajo rápido `agy .` / `ag` para abrir proyectos en Antigravity IDE.

---

## 🚀 Instalación y Restauración Automática (`install.ps1`)

Si formateas la máquina o configuras un nuevo entorno, solo necesitas clonar o copiar esta carpeta y ejecutar en PowerShell:

```powershell
# 1. Navegar a esta carpeta
cd "C:\Ruta\A\SerphClink"

# 2. Ejecutar el instalador maestro
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### ¿Qué hace `install.ps1` de forma 100% automática?
1. Descarga e instala **Starship**, **Clink** y **Fastfetch** directo desde GitHub.
2. Añade las herramientas al `PATH` de usuario de forma permanente.
3. Configura Clink con autocompletado y auto-carga de macros para CMD.
4. Despliega la configuración `starship.toml` en `~/.config/starship.toml`.
5. Despliega los atajos en `~/.config/powershell/serph_aliases.ps1`.
6. Configura los perfiles de **Windows PowerShell 5.1** y **PowerShell 7**.
7. Configura **MSYS2** (usuario `/home/kali`, Fastfetch, Starship) y registra el perfil en **Windows Terminal**.
8. Configura los accesos directos `agy` / `antigravity`.

---

## 🔤 Requisito Visual (Nerd Font)
Para ver correctamente todos los glifos e iconos en Windows Terminal:
* Descarga e instala **JetBrainsMono Nerd Font** o **FiraCode Nerd Font** desde [nerdfonts.com](https://www.nerdfonts.com/).
* En Windows Terminal, ve a `Configuración -> Perfil -> Apariencia -> Fuente` y selecciona tu Nerd Font.

---

## 💡 Comandos de Ayuda
En cualquier terminal (CMD o PowerShell), escribe:
```bash
aliases
# o también:
serph-help
```
