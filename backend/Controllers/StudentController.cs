using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StudentApi.Data;
using StudentApi.Models;

namespace StudentApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class StudentsController : ControllerBase
{
    private readonly AppDbContext _db;

    public StudentsController(AppDbContext db) => _db = db;

    // GET api/students
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var students = await _db.Students
            .OrderByDescending(s => s.CreatedAt)
            .ToListAsync();
        return Ok(students);
    }

    // GET api/students/5
    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var student = await _db.Students.FindAsync(id);
        return student is null ? NotFound() : Ok(student);
    }

    // POST api/students
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] Student student)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        bool duplicate = await _db.Students.AnyAsync(s => s.RollNo == student.RollNo);
        if (duplicate)
            return Conflict(new { message = $"Roll No. '{student.RollNo}' already exists." });

        student.CreatedAt = DateTime.UtcNow;
        _db.Students.Add(student);
        await _db.SaveChangesAsync();
        return CreatedAtAction(nameof(GetById), new { id = student.Id }, student);
    }

    // DELETE api/students/5
    [HttpDelete("{id:int}")]
    public async Task<IActionResult> Delete(int id)
    {
        var student = await _db.Students.FindAsync(id);
        if (student is null) return NotFound();
        _db.Students.Remove(student);
        await _db.SaveChangesAsync();
        return NoContent();
    }
}
