# A quick automation to update the color in the alacrity.toml file

def colorchange():
    with open('/Users/forrest/dotfiles/alacritty/alacritty.toml', 'r') as a:
        lines = a.readlines()
        line = lines[0]
        try:
            if 'gruvbox_dark' in line:
                line = line.replace('gruvbox_dark', 'solarized_light')
            elif 'solarized_light' in line:
                line = line.replace('solarized_light', 'gruvbox_dark')
        except:
            print('Error: Could not update the alacrity.toml file.')

        lines[0] = line

    with open('/Users/forrest/dotfiles/alacritty/alacritty.toml', 'w') as a:
        a.writelines(lines)

    return 'Color changed'

if __name__ == "__main__":
    colorchange()

