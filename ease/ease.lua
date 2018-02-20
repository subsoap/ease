-- Math based motion.

local M = {}

local pow, sin, cos, pi, sqrt, abs, asin  = math.pow, math.sin, math.cos, math.pi, math.sqrt, math.abs, math.asin

function M.linear(time_current, time_total, value_start, value_end)
  return value_end * time_current / time_total + value_start
end

-- time_current^2
function M.in_quadratic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total
  return value_end * pow(time_current, 2) + value_start
end

function M.out_quadratic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total
  return -value_end * time_current * (time_current - 2) + value_start
end

function M.in_out_quadratic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total * 2
  if time_current < 1 then
    return value_end / 2 * pow(time_current, 2) + value_start
  else
    return -value_end / 2 * ((time_current - 1) * (time_current - 3) - 1) + value_start
  end
end

function M.out_in_quadratic(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_quadratic (time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_quadratic((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end

-- time_current^3
function M.in_cubic (time_current, time_total, value_start, value_end)
  time_current = time_current / time_total
  return value_end * pow(time_current, 3) + value_start
end

function M.out_cubic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total - 1
  return value_end * (pow(time_current, 3) + 1) + value_start
end

function M.in_out_cubic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total * 2
  if time_current < 1 then
    return value_end / 2 * time_current * time_current * time_current + value_start
  else
    time_current = time_current - 2
    return value_end / 2 * (time_current * time_current * time_current + 2) + value_start
  end
end

function M.out_in_cubic(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_cubic(time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_cubic((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end

-- time_current^4
function M.in_quartic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total
  return value_end * pow(time_current, 4) + value_start
end

function M.out_quartic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total - 1
  return -value_end * (pow(time_current, 4) - 1) + value_start
end

function M.in_qut_quartic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total * 2
  if time_current < 1 then
    return value_end / 2 * pow(time_current, 4) + value_start
  else
    time_current = time_current - 2
    return -value_end / 2 * (pow(time_current, 4) - 2) + value_start
  end
end

function M.out_in_quartic(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_quartic(time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_quartic((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end

-- time_current^5
function M.in_quintic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total
  return value_end * pow(time_current, 5) + value_start
end

function M.out_quintic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total - 1
  return value_end * (pow(time_current, 5) + 1) + value_start
end

function M.in_out_quintic(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total * 2
  if time_current < 1 then
    return value_end / 2 * pow(time_current, 5) + value_start
  else
    time_current = time_current - 2
    return value_end / 2 * (pow(time_current, 5) + 2) + value_start
  end
end

function M.out_in_quintic(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_quintic(time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_quintic((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end

-- sin(time_current)
function M.in_sine(time_current, time_total, value_start, value_end)
  return -value_end * cos(time_current / time_total * (pi / 2)) + value_end + value_start
end

function M.out_sine(time_current, time_total, value_start, value_end)
  return value_end * sin(time_current / time_total * (pi / 2)) + value_start
end

function M.in_out_sine(time_current, time_total, value_start, value_end)
  return -value_end / 2 * (cos(pi * time_current / time_total) - 1) + value_start
end

function M.out_in_sine(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_sine(time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_sine((time_current * 2) -time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end

-- 2^time_current
function M.in_exponential(time_current, time_total, value_start, value_end)
  if time_current == 0 then
    return value_start
  else
    return value_end * pow(2, 10 * (time_current / time_total - 1)) + value_start - value_end * 0.001
  end
end

function M.out_exponential(time_current, time_total, value_start, value_end)
  if time_current == time_total then
    return value_start + value_end
  else
    return value_end * 1.001 * (-pow(2, -10 * time_current / time_total) + 1) + value_start
  end
end

function M.in_out_exponential(time_current, time_total, value_start, value_end)
  if time_current == 0 then return value_start end
  if time_current == time_total then return value_start + value_end end
  time_current = time_current / time_total * 2
  if time_current < 1 then
    return value_end / 2 * pow(2, 10 * (time_current - 1)) + value_start - value_end * 0.0005
  else
    time_current = time_current - 1
    return value_end / 2 * 1.0005 * (-pow(2, -10 * time_current) + 2) + value_start
  end
end

function M.out_in_exponential(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_exponential(time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_exponential((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end

-- sqrt(1-time_current^2)
function M.in_circular(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total
  return(-value_end * (sqrt(1 - pow(time_current, 2)) - 1) + value_start)
end

function M.out_circular(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total - 1
  return(value_end * sqrt(1 - pow(time_current, 2)) + value_start)
end

function M.in_out_circular(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total * 2
  if time_current < 1 then
    return -value_end / 2 * (sqrt(1 - time_current * time_current) - 1) + value_start
  else
    time_current = time_current - 2
    return value_end / 2 * (sqrt(1 - time_current * time_current) + 1) + value_start
  end
end

function M.out_in_circular(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_circular(time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_circular((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end

-- exponentially decaying sine wave
function M.in_elastic(time_current, time_total, value_start, value_end, amplitude, period)
  if time_current == 0 then return value_start end

  time_current = time_current / time_total

  if time_current == 1  then return value_start + value_end end

  if not period then period = time_total * 0.3 end

  local overshoot

  if not amplitude or amplitude < abs(value_end) then
    amplitude = value_end
    overshoot = period / 4
  else
    overshoot = period / (2 * pi) * asin(value_end/amplitude)
  end

  time_current = time_current - 1

  return -(amplitude * pow(2, 10 * time_current) * sin((time_current * time_total - overshoot) * (2 * pi) / period)) + value_start
end

function M.out_elastic(time_current, time_total, value_start, value_end, amplitude, period)
  if time_current == 0 then return value_start end

  time_current = time_current / time_total

  if time_current == 1 then return value_start + value_end end

  if not period then period = time_total * 0.3 end

  local overshoot

  if not amplitude or amplitude < abs(value_end) then
    amplitude = value_end
    overshoot = period / 4
  else
    overshoot = period / (2 * pi) * asin(value_end/amplitude)
  end

  return amplitude * pow(2, -10 * time_current) * sin((time_current * time_total - overshoot) * (2 * pi) / period) + value_end + value_start
end


function M.in_out_elastic(time_current, time_total, value_start, value_end, amplitude, period)
  if time_current == 0 then return value_start end

  time_current = time_current / time_total * 2

  if time_current == 2 then return value_start + value_end end

  if not period then period = time_total * (0.3 * 1.5) end
  if not amplitude then amplitude = 0 end

  local overshoot

  if not amplitude or amplitude < abs(value_end) then
    amplitude = value_end
    overshoot = period / 4
  else
    overshoot = period / (2 * pi) * asin(value_end / amplitude)
  end

  if time_current < 1 then
    time_current = time_current - 1
    return -0.5 * (amplitude * pow(2, 10 * time_current) * sin((time_current * time_total - overshoot) * (2 * pi) / period)) + value_start
  else
    time_current = time_current - 1
    return amplitude * pow(2, -10 * time_current) * sin((time_current * time_total - overshoot) * (2 * pi) / period ) * 0.5 + value_end + value_start
  end
end

function M.out_in_elastic(time_current, time_total, value_start, value_end, amplitude, period)
  if time_current < time_total / 2 then
    return M.out_elastic(time_current * 2, value_start, value_end / 2, time_total, amplitude, period)
  else
    return M.in_elastic((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total, amplitude, period)
  end
end


-- overshooting cubic easing (overshoot+1)*time_current^3 - overshoot*time_current^2
function M.in_back(time_current, time_total, value_start, value_end, overshoot)
  if not overshoot then overshoot = 1.70158 end
  time_current = time_current / time_total
  return value_end * time_current * time_current * ((overshoot + 1) * time_current - overshoot) + value_start
end

-- back easing out: moving towards target overshooting it then reversing and coming back to target
function M.out_back(time_current, time_total, value_start, value_end, overshoot)
  if not overshoot then overshoot = 1.70158 end
  time_current = time_current / time_total - 1
  return value_end * (time_current * time_current * ((overshoot + 1) * time_current + overshoot) + 1) + value_start
end

function M.in_out_back(time_current, time_total, value_start, value_end, overshoot)
  if not overshoot then overshoot = 1.70158 end
  overshoot = overshoot * 1.525
  time_current = time_current / time_total * 2
  if time_current < 1 then
    return value_end / 2 * (time_current * time_current * ((overshoot + 1) * time_current - overshoot)) + value_start
  else
    time_current = time_current - 2
    return value_end / 2 * (time_current * time_current * ((overshoot + 1) * time_current + overshoot) + 2) + value_start
  end
end

function M.out_in_back(time_current, time_total, value_start, value_end, overshoot)
  if time_current < time_total / 2 then
    return M.out_back(time_current * 2, value_start, value_end / 2, time_total, overshoot)
  else
    return M.in_back((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total, overshoot)
  end
end

-- exponentially decaying parabolic bounce
function M.out_bounce(time_current, time_total, value_start, value_end)
  time_current = time_current / time_total
  if time_current < 1 / 2.75 then
    return value_end * (7.5625 * time_current * time_current) + value_start
  elseif time_current < 2 / 2.75 then
    time_current = time_current - (1.5 / 2.75)
    return value_end * (7.5625 * time_current * time_current + 0.75) + value_start
  elseif time_current < 2.5 / 2.75 then
    time_current = time_current - (2.25 / 2.75)
    return value_end * (7.5625 * time_current * time_current + 0.9375) + value_start
  else
    time_current = time_current - (2.625 / 2.75)
    return value_end * (7.5625 * time_current * time_current + 0.984375) + value_start
  end
end

function M.in_bounce(time_current, time_total, value_start, value_end)
  return value_end - M.out_bounce(time_total - time_current, 0, value_end, time_total) + value_start
end

function M.in_out_bounce(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.in_bounce(time_current * 2, 0, value_end, time_total) * 0.5 + value_start
  else
    return M.out_bounce(time_current * 2 - time_total, 0, value_end, time_total) * 0.5 + value_end * .5 + value_start
  end
end

function M.out_in_bounce(time_current, time_total, value_start, value_end)
  if time_current < time_total / 2 then
    return M.out_bounce(time_current * 2, value_start, value_end / 2, time_total)
  else
    return M.in_bounce((time_current * 2) - time_total, value_start + value_end / 2, value_end / 2, time_total)
  end
end
  
return M