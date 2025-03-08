class CreateCourseLearningRoutes < ActiveRecord::Migration[7.2]
  def change
    create_join_table :courses, :learning_routes do |t|
      t.index [:course_id, :learning_route_id]
      t.index [:learning_route_id, :course_id]
    end
  end
end
