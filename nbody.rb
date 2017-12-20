require "gosu"
#require "./reader"
require "./body"
require_relative "z_order"
require "./simulation"

class NbodySimulation < Gosu::Window

   def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    amount_of_bodies, radius, bodies = 0, 0, []
    file_name = ARGV
      File.open("./simulations/#{file_name[0]}") do |file|

        file.each_line.with_index do |line, i|
          if i == 0
            amount_of_bodies = line
          elsif i == 1
            radius = line
          else
            body_pieces = line.gsub(/\s+/m, ' ').strip.split(" ")
            if body_pieces[0] == nil
              next
            end
            if body_pieces[0] == "Creator"
              break
            end
            bodies.push(Body.new(body_pieces[0], body_pieces[1], body_pieces[2], body_pieces[3], body_pieces[4], body_pieces[5]. body_pieces[6], body_pieces[7]))
          end
        end
      end
      @simulation = Simulation.new(amount_of_bodies, radius, bodies)
  end

  def update
    @simulation.update
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @simulation.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show

