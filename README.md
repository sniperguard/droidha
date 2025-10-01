# Droid Terminal for Home Assistant

This repository contains a custom add-on that integrates Factory's Droid CLI with Home Assistant.

## Installation

To add this repository to your Home Assistant instance:

1. Go to **Settings** → **Add-ons** → **Add-on Store**
2. Click the three dots menu in the top right corner
3. Select **Repositories**
4. Add the URL: `https://github.com/marcel/droidha` (replace with your actual repository URL)
5. Click **Add**

## Add-ons

### Droid Terminal

A web-based terminal interface with Droid CLI pre-installed. This add-on provides a terminal environment directly in your Home Assistant dashboard, allowing you to use Droid's powerful AI capabilities for coding, automation, and configuration tasks.

Features:

- Web terminal access through your Home Assistant UI
- Pre-installed Droid CLI that launches automatically
- Direct access to your Home Assistant config directory
- OAuth-based authentication
- Access to Droid's complete capabilities including:
  - Code generation and debugging
  - Home Assistant automation assistance
  - File system operations
  - Learning and documentation resources

[Documentation](./droid-terminal/DOCS.md)

## Configuration

The add-on supports the following configuration options:

- **auto_launch_droid**: Automatically launch Droid CLI when terminal opens (default: true)

## Support

If you have any questions or issues with this add-on, please create an issue in this repository.

## Credits

This add-on was inspired by the Claude Terminal add-on structure and adapted for Factory's Droid CLI.

## License

This repository is licensed under the MIT License.
