require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      @employee1 = Employee.new
      post employees_url, params: { employee: { active: @employee1.active, date_of_birth: @employee1.date_of_birth, first_name: @employee1.first_name, last_name: @employee1.last_name, phone: @employee1.phone, role: @employee1.role, ssn: @employee1.ssn } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { active: @employee.active, date_of_birth: @employee.date_of_birth, first_name: @employee.first_name, last_name: @employee.last_name, phone: @employee.phone, role: @employee.role, ssn: @employee.ssn } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
