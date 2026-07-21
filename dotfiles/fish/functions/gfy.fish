function gfy --description 'graphify via OpenRouter (key from $OPENROUTER_API_KEY)'
    if not command -q graphify
        echo "gfy: ✗ \`graphify\` not on PATH (uv tool install 'graphifyy[pdf,office,openai]')" >&2
        return 1
    end
    if test -z "$OPENROUTER_API_KEY"
        echo "gfy: ✗ \$OPENROUTER_API_KEY unset — set it in ~/.config/fish/conf.d/secrets.fish" >&2
        return 1
    end

    # OPENAI_* is how graphify addresses any OpenAI-compatible endpoint; scoped to
    # this command so the key never leaks into other tools' environments.
    env OPENAI_API_KEY=$OPENROUTER_API_KEY \
        OPENAI_BASE_URL=https://openrouter.ai/api/v1 \
        OPENAI_MODEL=google/gemini-2.5-flash \
        graphify $argv --backend openai
end
