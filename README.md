# ⚡ SerphClink - Cyberpunk 2077 Terminal Suite

Suite completa de personalización y productividad para la terminal de Windows (PowerShell y CMD) inspirada en la interfaz **HUD de Cyberpunk 2077**.

---

## 📦 ¿Qué incluye?

* **Starship Prompt:** Tema temático *Cyberpunk 2077 HUD* (Yellow `#FCEE0A`, Trauma Team Red `#FF003C`, Kiroshi Cyan `#00F0FF`, advertencia `RELIC MALFUNCTION` en errores).
* **Clink (para CMD):** Autocompletado inteligente estilo Fish, historial persistente y puente directo para que CMD tenga el mismo prompt de Starship.
* **Serph Toolkit (Atajos y Macros):** Más de 80 atajos para Git, desarrollo web (NPM/Bun/PNPM), Prisma, Flutter, Python, Docker, redes y utilidades de sistema.
* **Antigravity CLI:** Atajo rápido `agy .` / `ag` para abrir proyectos en Antigravity IDE.

---

## 🚀 Instalación en una PC nueva (Post-Formateo)

Si formateas la máquina, solo necesitas clonar o copiar esta carpeta y ejecutar el instalador automatizado en PowerShell:

```powershell
# 1. Abrir PowerShell y navegar a esta carpeta
cd "C:\Ruta\A\SerphClink"

# 2. Ejecutar el instalador automático
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### ¿Qué hace `install.ps1` automáticamente?
1. Descarga e instala la última versión de **Starship** y **Clink**.
2. Añade ambos al `PATH` del usuario.
3. Habilita el `autorun` y autocompletado en CMD con Clink.
4. Despliega la configuración `starship.toml` en `~/.config/starship.toml`.
5. Despliega los atajos en `~/.config/powershell/serph_aliases.ps1`.
6. Configura los perfiles de **Windows PowerShell 5.1** y **PowerShell 7**.
7. Configura los accesos directos `agy` / `antigravity`.

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
