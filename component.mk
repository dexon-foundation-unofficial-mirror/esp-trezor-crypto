#
# Main component makefile.
#
# This Makefile can be left empty. By default, it will take the sources in the
# src/ directory, compile them and link them into lib(subdirectory_name).a
# in the build directory. This behaviour is entirely configurable,
# please read the ESP-IDF documents if you need to do this.
COMPONENT_ADD_INCLUDEDIRS := . include
COMPONENT_PRIV_INCLUDEDIRS := .
COMPONENT_SRCDIRS := .

ifdef $(or $(CONFIG_USE_KECCAK), $(CONFIG_USE_MONERO), $(CONFIG_USE_NEM), $(CONFIG_USE_CARDANO))
COMPONENT_SRCDIRS += ed25519-donna
endif

ifdef $(CONFIG_USE_MONERO)
COMPONENT_SRCDIRS += monero
endif

ifdef $(CONFIG_USE_NEM)
COMPONENT_SRCDIRS += aes
endif

ifdef $(CONFIG_USE_CHACHA20POLY1305)
COMPONENT_SRCDIRS += chacha20poly1305
endif

# Defines
CONFIGS =  \
	USE_ETHEREUM \
	USE_GRAPHENE \
	USE_KECCAK \
	USE_MONERO \
	USE_NEM \
	USE_CARDANO

$(foreach c,$(CONFIGS),$(eval $(if $(CONFIG_$(c)), CFLAGS += -D$(c)=1, CFLAGS += -D$(c)=0)))
