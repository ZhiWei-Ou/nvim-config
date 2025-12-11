.PHONY: test
test:
	@nvim --headless --noplugin -u spec/minimal_init.lua \
    -c "PlenaryBustedDirectory spec/ { minimal_init = 'spec/minimal_init.lua' }"

.PHONY: clean-test
clean-test:
	rm -rf ~/.local/share/nvim/lazy-test
