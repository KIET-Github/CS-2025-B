from django.db import models

class Scheme(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    more = models.CharField(max_length=100, null=True)

    def __str__(self):
        return self.name
