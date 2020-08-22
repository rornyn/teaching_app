require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:one)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector "h1", text: "Courses"
  end

  test "creating a Course" do
    visit courses_url
    click_on "New Course"

    fill_in "Content", with: @course.content
    fill_in "End dt", with: @course.end_dt
    fill_in "Start dt", with: @course.start_dt
    fill_in "Status", with: @course.status
    fill_in "Student length", with: @course.student_length
    fill_in "Teacher", with: @course.teacher_id
    fill_in "Title", with: @course.title
    click_on "Create Course"

    assert_text "Course was successfully created"
    click_on "Back"
  end

  test "updating a Course" do
    visit courses_url
    click_on "Edit", match: :first

    fill_in "Content", with: @course.content
    fill_in "End dt", with: @course.end_dt
    fill_in "Start dt", with: @course.start_dt
    fill_in "Status", with: @course.status
    fill_in "Student length", with: @course.student_length
    fill_in "Teacher", with: @course.teacher_id
    fill_in "Title", with: @course.title
    click_on "Update Course"

    assert_text "Course was successfully updated"
    click_on "Back"
  end

  test "destroying a Course" do
    visit courses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course was successfully destroyed"
  end
end
