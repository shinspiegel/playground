package shin

import javax.ws.rs.Consumes
import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces
import javax.ws.rs.core.MediaType

@Path("/employees")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
class EmployeeResource(val repository: EmployeeRepository) {

    @POST
    @Transactional
    fun add(employee: Employee): Response {
        repository.persist(employee)
        return Response.ok(employee).status(201).build()
    }

    @DELETE
    @Path("/{id}")
    @Transactional
    fun delete(@PathParam id: Long) {
        repository.deleteById(id)
    }

    @GET fun findAll(): List<Employee> = repository.listAll()

    @GET @Path("/{id}") fun findById(@PathParam id: Long): Employee? = repository.findById(id)

    @GET
    @Path("/first-name/{firstName}/last-name/{lastName}")
    fun findByFirstNameAndLastName(
            @PathParam firstName: String,
            @PathParam lastName: String
    ): List<Employee> = repository.findByFirstNameAndLastName(firstName, lastName)

    @GET
    @Path("/salary/{salary}")
    fun findBySalary(@PathParam salary: Int): List<Employee> = repository.findBySalary(salary)

    @GET
    @Path("/salary-greater-than/{salary}")
    fun findBySalaryGreaterThan(@PathParam salary: Int): List<Employee> =
            repository.findBySalaryGreaterThan(salary)
}
