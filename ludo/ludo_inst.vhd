	component ludo is
		port (
			clk_clk                        : in  std_logic                    := 'X'; -- clk
			hex_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			led_external_connection_export : out std_logic_vector(2 downto 0)         -- export
		);
	end component ludo;

	u0 : component ludo
		port map (
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                     clk.clk
			hex_external_connection_export => CONNECTED_TO_hex_external_connection_export, -- hex_external_connection.export
			led_external_connection_export => CONNECTED_TO_led_external_connection_export  -- led_external_connection.export
		);

