# Entropy prompt theme, by Justin Mayer <https://justinmayer.com/>
# Repository: <https://github.com/justinmayer/entropy-theme>
function fish_prompt -d "Write out the prompt"

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_virtualenv_color
        set -g __fish_prompt_virtualenv_color (set_color blue)
    end

    if not set -q __fish_prompt_userhost_color
        set -g __fish_prompt_userhost_color (set_color blue)
    end

    if not set -q __fish_prompt_repo_branch_color
        set -g __fish_prompt_repo_branch_color (set_color magenta)
    end

    if not set -q __fish_prompt_repo_status_color
        set -g __fish_prompt_repo_status_color (set_color blue)
    end

    if not set -q __fish_prompt_gray
        set -g __fish_prompt_gray (set_color -o black)
    end

    # Git prompt settings
    if not set -q __fish_git_prompt_showdirtystate
        set -g __fish_git_prompt_showdirtystate "true"
    end
    if not set -q __fish_git_prompt_char_dirtystate
        set -g __fish_git_prompt_char_dirtystate "!"
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate "blue"
    end
    if not set -q __fish_git_prompt_showuntrackedfiles
        set -g __fish_git_prompt_showuntrackedfiles "true"
    end
    if not set -q __fish_git_prompt_char_untrackedfiles
        set -g __fish_git_prompt_char_untrackedfiles "?"
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles "blue"
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch "magenta"
    end

    # Set up Git prompt
    set -g __vcprompt $__fish_prompt_gray' on '(__fish_git_prompt "%s" | sed 's/ //')

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        set -g __fish_prompt_char ' # '

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        set -g __fish_prompt_char ' ➤ '

    end

    if [ -z $SSH_CONNECTION ]

        if not set -q __fish_prompt_userhost
            set -g __fish_prompt_userhost
        end

    else

        if not set -q __fish_prompt_userhost
            set -g __fish_prompt_userhost $__fish_prompt_userhost_color$USER"@"$__fish_prompt_hostname" "
        end

    end

    if set -q VIRTUAL_ENV
        if not set -q __fish_prompt_virtualenv
            set __fish_prompt_virtualenv $__fish_prompt_virtualenv_color"("(basename "$VIRTUAL_ENV")")"$__fish_prompt_normal" "
        end
    end

    echo -n -s "$__fish_prompt_userhost" "$__fish_prompt_virtualenv" "$__fish_prompt_cwd" (prompt_pwd) "$__vcprompt" "$__fish_prompt_normal" "$__fish_prompt_char"

end
