local function handler(msg)
	msg = tostring(msg)

    print((debug.traceback("Error: " .. tostring(msg), 1+(2 or 1)):gsub("\n[^\n]+$", "")))

	if not love.window or not love.graphics or not love.event then
		return
	end

	if not love.graphics.isCreated() or not love.window.isOpen() then
		local success, status = pcall(love.window.setMode, 800, 600)
		if not success or not status then
			return
		end
	end

	-- Reset state.
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
		love.mouse.setRelativeMode(false)
		if love.mouse.isCursorSupported() then
			love.mouse.setCursor()
		end
	end
	if love.joystick then
		-- Stop all joystick vibrations.
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end
	if love.audio then love.audio.stop() end

	love.graphics.reset()
	love.graphics.origin()
    local font1 = love.graphics.newFont(26)
    local font2 = love.graphics.newFont(15)
	local function draw()
		local pos = 70
		love.graphics.clear(0, 0, 0)
        love.graphics.setColor(1, 1, 1, 1)
		love.graphics.printf("No Parachute has crashed!", 70, pos, love.graphics.getWidth(), "left")
        pos = pos + 50
        love.graphics.setColor(0.8, 0.8, 0.8)
        love.graphics.printf(msg, 70, pos, love.graphics.getWidth(), "left")
		love.graphics.present()
	end

	return function()
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return 1
			elseif e == "keypressed" and a == "escape" then
				return 1
            end
		end

		draw()

		if love.timer then
			love.timer.sleep(0.1)
		end
	end
end

return handler