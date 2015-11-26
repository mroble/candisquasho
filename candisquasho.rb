require 'gosu'

class CandiSquasho < Gosu::Window

  def initialize
    super(800,600)
    self.caption = "Squash a Candidate!"
    @image = Gosu::Image.new('edited_trump.png')
    @x = 200
    @y = 200
    @width = 50
    @height = 43
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @pope_image= Gosu::Image.new('edited_pope_francis.png')
    @x_2 = 125
    @y_2 = 125
    @width_2 = 40
    @height_2 = 40
    @velocity_x_2 = 4
    @velocity_y_2 = 4
    @visible_2 = 0
    @starbucks_image= Gosu::Image.new('edited_red_cup.png')
    @x_3 = 300
    @y_3 = 300
    @width_3 = 40
    @height_3 = 40
    @velocity_x_3 = 6
    @velocity_y_3 = 5
    @visible_3 = 0
    @poop_image = Gosu::Image.new('edited_unicorn_poop.png')
    @hit = 0  
    @score = 0
    @font = Gosu::Font.new(30)
    @playing = true
    @start_time = 0
end

  def update
    if @playing 
      @x += @velocity_x
      @y += @velocity_y
      @visible -= 1
      @x_2 += @velocity_x_2
      @y_2 += @velocity_y_2
      @visible_2 -= 1
      @x_3 += @velocity_x_3
      @y_3 += @velocity_y_3
      @visible_3 -= 1
      @time_left = (100 - ((Gosu.milliseconds - @start_time) / 1000))
      @playing = false if @time_left < 0
      @velocity_x *= -1 if @x + @width/2 > 800 || @x - @width / 2 < 0
      @velocity_y *= -1 if @y + @height/2 > 600 || @y - @height / 2 < 0
      @velocity_x_2 *= -1 if @x_2 + @width_2/2 > 800 || @x_2 - @width_2 / 2 < 0
      @velocity_y_2 *= -1 if @y_2 + @height_2/2 > 600 || @y_2 - @height_2 / 2 < 0
      @velocity_x_3 *= -1 if @x_3 + @width_3/2 > 800 || @x_3 - @width_3 / 2 < 0
      @velocity_y_3 *= -1 if @y_3 + @height_3/2 > 600 || @y_3 - @height_3 / 2 < 0
      @visible = 75 if @visible < -10 and rand < 0.01
      @visible_2 = 90 if @visible_2 < -10 and rand < 0.01
      @visible_3 = 60 if @visible_3 < -10 and rand < 0.01
    end
  end
  def button_down(id)
    if @playing
      if (id == Gosu::MsLeft)
        if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
          @hit = 1 
          @score += 100
        else
          @hit = -1
          @score -= 1
        end
      end
    else
      if (id == Gosu::KbSpace)
        @playing = true
        @visible = -10
        @visible_2 = -8
        @visible_3 = -4
        @start_time = Gosu.milliseconds
        @score = 0
      end
    end
  end
  
  def draw
    if @visible > 0
      @image.draw(@x - @width / 2, @y - @height / 2, 1)
    end
    if @visible_2 > 0
      @pope_image.draw(@x_2 - @width / 2, @y_2 - @height_2 / 2, 1)
    end
    if @visible_3 > 0
      @starbucks_image.draw(@x_2 - @width / 2, @y_2 - @height_2 / 2, 1)
    end
    @poop_image.draw(mouse_x - 40, mouse_y - 10, 1)
    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
    @font.draw(@time_left.to_s, 20, 20, 2)
    @font.draw(@score.to_s, 700, 20, 2)
    unless @playing
       @font.draw('Game Over', 300, 300, 3)
       @font.draw('Press the Space Bar to Play Again', 175, 350, 3)
       @visible = 20
       @visible_2 = 20
       @visible_3 = 20
    end
  end
end

window = CandiSquasho.new
window.show