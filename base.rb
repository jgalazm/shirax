mod = Sketchup.active_model # Open model
ent = mod.entities # All entities in model
sel = mod.selection # Current selection

def readDatos(inputString,convert_option)
  inputPoints = IO.readlines(inputString)
  data = {}
  inputPoints.map{|l|
    l = l.split(' ')
    for i in 1..l.length-1
      if convert_option == 1
        #convert to float (for points)
        l[i] = l[i].to_f
      else
        #dont convert, use string (for lines)
        l[i] = l[i]
      end
    end
    data[l[0]] = l[1..l.length-1]
  }
  return data
end


#data
pointsFile = UI.openpanel("Abrir archivo de puntos", "c:/", "points.txt")
points = readDatos(pointsFile,1)
linesFile = UI.openpanel("Abrir archivo de lineas", "c:/", "lines.txt")
lines = readDatos(linesFile,2)



#main surface
coords = points.values_at(*lines["face"])
ent.add_face(coords)


#draw lines
group = Sketchup.active_model.entities.add_group
lines.keys.each {|lkey|
    coords = points.values_at(*lines[lkey])
    group.entities.add_line(coords)
}
ls = group.explode





