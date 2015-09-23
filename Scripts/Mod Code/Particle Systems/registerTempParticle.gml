/* Registers a temporary particle in the Particle Controller, scheduling it for deletion when its maximum
** lifetime has expired.
**
** argument0 = Particle Type ID (must exist beforehand)
** argument1 = Minimum lifetime
** argument2 = Maximum lifetime
** argument3 = Additional grace time to add before the particle is deleted
**              (necessary for particles that are streamed, rather than immediately bursted)
*/
{
    var i, insertPoint, reduce;
    
    // first, set the particle's lifetime
    part_type_life(argument0, argument1, argument2);
    
    // figure out how much to reduce the remaining lifetime of every particle by
    reduce = ParticleController.lifeReduction - ParticleController.alarm[0];
    ParticleController.lifeReduction -= reduce;
    
    // next, figure out where in the list the particle should be added
    // (the list must be sorted by remaining lifetime)
    insertPoint = ds_list_size(ParticleController.tempParticlesLife);
    for (i = 0; i < ds_list_size(ParticleController.tempParticlesLife); i += 1) {
        // reduce the life of the particle to account for the new addition
        ds_list_replace(ParticleController.tempParticlesLife, i, ds_list_find_value(ParticleController.tempParticlesLife, i) - reduce);
        // if the new particle is younger than the compared particle, insert here
        if (argument2 + argument3 < ds_list_find_value(ParticleController.tempParticlesLife, i)) {
            insertPoint = i;
        }
    }
    
    // if the insertion point is 0 (ahead of all the others), then reset the timer to equal the new max life
    if (insertPoint == 0) {
        ParticleController.alarm[0] = argument2 + argument3;
        ParticleController.lifeReduction = argument2 + argument3;
    }
    
    // insert the particle type
    ds_list_insert(ParticleController.tempParticlesID, insertPoint, argument0);
    ds_list_insert(ParticleController.tempParticlesLife, insertPoint, argument2 + argument3);
}
